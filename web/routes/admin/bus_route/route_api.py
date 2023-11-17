from json import dumps
from flask import jsonify, render_template, request
from routes.admin.helper import login_required, roles_required, serialize
from app import chuyenxe, app, lotrinh, taixe, xebus
from routes.admin import  *
from sqlalchemy import or_

#quản lý tuyến đường
#page
@padmin.route("/add_route")
@login_required
@roles_required("3")
def add_route():
    get_bus = app.db_session.query(xebus).filter_by(TinhTrang = 1).all()
    get_driver = app.db_session.query(taixe).filter_by(TrangThai = 1).all()
    return render_template('admin/add_route.html', buses = get_bus, drivers = get_driver)    
@padmin.route("/route_list")
@login_required
@roles_required("3")
def route_list():
    return render_template('admin/route_list.html')  


@padmin.route("/route_detail/<int:id>")
@login_required
@roles_required("3")
def route_detail(id):
    get_route = app.db_session.query(chuyenxe).filter_by(MaChuyen = id).first()
    if (get_route != None):
        route_id = get_route.MaChuyen
        
        point_list = app.db_session.query(lotrinh).filter_by(MaChuyen = route_id).all()
        for i in point_list:
            print(i.TenDiem)
        get_bus = app.db_session.query(xebus).filter(or_(xebus.TinhTrang == 1, xebus.MaXeBus == get_route.MaXeBus)).all()
        get_driver = app.db_session.query(taixe).filter(or_(taixe.TrangThai == 1, taixe.MaTaiXe == get_route.MaTaiXe)).all()
        return render_template('admin/route_detail.html', route = get_route, point_list = point_list, buses = get_bus, drivers = get_driver)  
    else:
        return jsonify({'error' : True, 'message' : 'Tuyến xe không tồn tại!'})

#api
@padmin.route('/add_route_api', methods=['POST'])
def add_route_api():
    json = request.json
    name = json['name']	
    tkadlt = json['tkadlt']	
    tkchild = json['tkchild']	
    begin_time = json['begin_time']	
    est = json['est']	
    begin_point = json['begin_point']	
    bus = json['bus']	
    driver = json['driver']	
    end_point = json['end_point']	    
    note = json['note']
    tx = app.db_session.query(taixe).filter_by(MaTaiXe = driver).first()
    tx.TrangThai = 2
    xb = app.db_session.query(xebus).filter_by(MaXeBus = bus).first()
    xb.TinhTrang = 2   
    chuyen = chuyenxe(TenChuyen = name, MaXeBus = bus, MaTaiXe = driver, DiemBatDau = begin_point, DiemKetThuc = end_point, GioKhoiHanh = begin_time, 
        UocTinhThoiGian = est, GiaVeNguoiLon = tkadlt, GiaVeTreEm = tkchild, TrangThai = 1, LuuY = note
    )
    app.db_session.add(chuyen)
    app.db_session.commit()
    idChuyen = chuyen.MaChuyen
    print(json['mid_point_name'])
    for  idx, time in enumerate(json['mid_point_time']):
        print(json['mid_point_name'][idx])
        lt = lotrinh(MaChuyen = idChuyen, TenDiem = json['mid_point_name'][idx], Gio = time, ThuTu = idx)
        app.db_session.add(lt)
    app.db_session.commit()
    resp = jsonify({'error' : False, 'message' : 'Thêm chuyến mới thành công!'})
    return resp

@padmin.route('/update_route_api/<int:id>', methods=['POST'])
def update_route_api(id):
    json = request.json
    name = json['name']	
    tkadlt = json['tkadlt']	
    tkchild = json['tkchild']	
    begin_time = json['begin_time']	
    est = json['est']	
    begin_point = json['begin_point']	
    bus = json['bus']	
    driver = json['driver']	
    end_point = json['end_point']	    
    note = json['note']
    print(json['status'])
    status = int(json['status'])
     

    tuyen = app.db_session.query(chuyenxe).filter_by(MaChuyen = id).first()
    if (int(tuyen.MaXeBus) != int(bus)):
        current_bus = app.db_session.query(xebus).filter_by(MaXeBus = tuyen.MaXeBus).first()
        current_bus.TinhTrang = 1
        new_bus = app.db_session.query(xebus).filter_by(MaXeBus = bus).first()
        new_bus.TinhTrang = 2
        tuyen.MaXeBus = bus
    if (int(tuyen.MaTaiXe) != int(driver)):
        current_driver = app.db_session.query(taixe).filter_by(MaTaiXe = tuyen.MaTaiXe).first()
        current_driver.TrangThai = 1
        new_driver = app.db_session.query(taixe).filter_by(MaTaiXe = driver).first()
        new_driver.TrangThai = 2
        tuyen.MaTaiXe = driver
    tuyen.TenChuyen = name, 
    tuyen.DiemBatDau = begin_point, 
    tuyen.DiemKetThuc = end_point, 
    tuyen.GioKhoiHanh = begin_time, 
    tuyen.UocTinhThoiGian = est, 
    tuyen.GiaVeNguoiLon = tkadlt, 
    tuyen.GiaVeTreEm = tkchild, 
    tuyen.TrangThai = status
    tuyen.LuuY = note
    app.db_session.commit()
    idChuyen = tuyen.MaChuyen
    print(json['mid_point_name'])
    #xóa lộ trình cũ
    app.db_session.query(lotrinh).filter(lotrinh.MaChuyen == id).delete()
    for  idx, time in enumerate(json['mid_point_time']):
        print(json['mid_point_name'][idx])
        lt = lotrinh(MaChuyen = idChuyen, TenDiem = json['mid_point_name'][idx], Gio = time, ThuTu = idx)
        app.db_session.add(lt)
    app.db_session.commit()
    resp = jsonify({'error' : False, 'message' : 'Cập nhật tuyến thành công!'})
    return resp

@padmin.route("/update_route_status_api", methods = ['POST'])
def update_route_status_api():
    _json = request.json
    id = _json['id']
    cx = app.db_session.query(chuyenxe).filter_by(MaChuyen = id).first()
    cx.TrangThai = 0 if cx.TrangThai == 1 else 1
    app.db_session.commit()
    resp = jsonify({'error' : 'false'})
    return resp
    
@padmin.route("/del_route_api", methods = ['POST'])
def del_route_api():
    _json = request.json
    id = _json['id']
    cx = app.db_session.query(chuyenxe).filter_by(MaChuyen = id).first()
    current_bus = app.db_session.query(xebus).filter_by(MaXeBus = cx.MaXeBus).first()
    current_bus.TinhTrang = 1
    current_driver = app.db_session.query(taixe).filter_by(MaTaiXe = cx.MaTaiXe).first()
    current_driver.TinhTrang = 1
    if cx:
        app.db_session.delete(cx)
        app.db_session.commit()
        return jsonify({'error': False, 'message': 'Đã xóa thành công!'})
    else:
        return jsonify({'error': True, 'message': 'Tuyến xe không tồn tại'})

@padmin.route("/route_list_api")
def route_list_api():
    list = []
    r_list = app.db_session.query(chuyenxe).all()
    # we can then use this for your particular example
    list = [serialize(cx) for cx in r_list]

    data_json = dumps({'data' : list}, default = str)
    resp = data_json
    return resp