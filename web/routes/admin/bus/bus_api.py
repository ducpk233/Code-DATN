from json import dumps
from routes.admin import  *
from flask import Blueprint, jsonify, redirect, render_template, request, session, url_for

from app import ghexebus, xebus, app

from routes.admin.helper import login_required
from routes.admin.helper import serialize

#quản lý xe bus
#page
@padmin.route("/add_new_bus")
@login_required
def add_new_bus():
    return render_template('admin/add_new_bus.html')        
@padmin.route("/bus_list")

@login_required
def bus_list():
    return render_template('admin/bus_list.html')   

@padmin.route("/view_bus_detail/<int:id>", methods=['GET'])
@login_required
def view_bus_detail(id):
    get_bus = app.db_session.query(xebus).filter_by(MaXeBus = id).first()
    get_seats = app.db_session.query(ghexebus).filter_by(MaXeBus = id).all()
    return render_template('admin/view_bus_detail.html', bus = get_bus, seats = get_seats)   

#api
@padmin.route('/add_bus_api', methods=['POST'])
def add_bus_api():
    bus_seat_map = ["A", "B", "C", "D", "E", "F"]
    _json = request.json
    
    _sx = _json['sx']
    _lx = _json['lx']
    _sg = _json['sg']
    _bs = _json['bs']	
    exist = bool(app.db_session.query(xebus).filter_by(BienSoXe=_bs).first())
    if exist:
        resp = jsonify({'error' : True, 'message' : 'Biển số xe đã tồn tại!'})
        return resp
    else:
        xb =  xebus(BienSoXe = _bs, LoaiXe = _lx, SoGhe = _sg, SoXe = _sx, TinhTrang = 1 )
        app.db_session.add(xb)
        app.db_session.commit()
        maxebus = xb.MaXeBus
        #chèn 60 ghế vào bảng ghế của xe bus
        sg = 1
        for i in range(1, 11):
            for name in bus_seat_map:
                ghe = ghexebus(MaXeBus = maxebus, TenGhe = str(i) + name, SoGhe = 60, DaDat = 0 )
                app.db_session.add(ghe)
                sg += 1
        app.db_session.commit()
        resp = jsonify({'error' : False, 'message' : 'Đăng ký thành công!'})
        return resp

@padmin.route('/update_bus_api', methods=['POST'])
def update_bus_api():
    _json = request.json
    _id = _json['id']
    _sx = _json['sx']
    _lx = _json['lx']
    _bs = _json['bs']	
    _status = int(_json['status'])
    bus = app.db_session.query(xebus).filter_by(MaXeBus=_id).first()
    if bus:

        if (bus.BienSoXe != _bs):
            exist = bool(app.db_session.query(xebus).filter_by(BienSoXe=_bs).first())
            if exist:
                resp = jsonify({'error' : True, 'message' : 'Biển số xe đã tồn tại!'})
                return resp
            else:
                bus.BienSoXe = _bs
        bus.LoaiXe = _lx
        bus.SoXe = _sx
        bus.TinhTrang = _status
        app.db_session.commit()
        resp = jsonify({'error' : False, 'message' : 'Cập nhật thành công!'})
        return resp
    else:
        resp = jsonify({'error' : True, 'message' : 'Xe bus không tồn tại. Vui lòng tải lại trang!'})
        return resp

@padmin.route("/bus_list_api")
def bus_list_api():
    list = []
    bus_list = app.db_session.query(xebus).all()
    # we can then use this for your particular example
    list = [serialize(bus) for bus in bus_list]

    data_json = dumps({'data' : list})
    resp = data_json
    return resp

@padmin.route("/del_bus_api", methods = ['POST'])
def del_bus_api():
    _json = request.json
    id = _json['id']
    b = app.db_session.query(xebus).filter_by(MaXeBus = id).first()
    if b:
        app.db_session.delete(b)
        app.db_session.commit()
        return jsonify({'error': False, 'message': 'Đã xóa thành công!'})
    else:
        return jsonify({'error': True, 'message': 'Xe bus không tồn tại'})