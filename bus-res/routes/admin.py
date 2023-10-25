from datetime import datetime
from functools import wraps
from lib2to3.pgen2 import driver
from flask import Blueprint, jsonify, redirect, render_template, request, session, url_for
from sqlalchemy import false, true
from app import app, chuyenxe, ghexebus, lichsudatghe, nguoidung, khachhang, phuongthucthanhtoan, taixe, xebus, ghexebus, datve, lotrinh
from json import dumps
from sqlalchemy.orm import class_mapper
import json
admin = Blueprint('admin', __name__)


def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get('admin_id') is None and session.get('driver_id') is None:
            return redirect(url_for('admin.login_page'))
        return f(*args, **kwargs)
    return decorated_function

@admin.route("/")
@login_required
def admin_home():
    return render_template('admin/index.html')



#phần dành cho tài xế
@admin.route("/driver_ticket_list")
@login_required
def driver_ticket_list():
    
    return render_template('admin/driver_ticket_list.html')  
    
        
@admin.route("/driver_ticket_list_api")
@login_required
def driver_ticket_list_api():
    get_driver_info = app.db_session.query(taixe).filter_by(MaNguoiDung = session['driver_id']).first()
    print(session['driver_id'])
    list = []
    get_route = app.db_session.query(chuyenxe).filter_by(MaTaiXe = get_driver_info.MaTaiXe).first()
    
    if bool(get_route):
        get_ticket_list = app.db_session.query(datve).filter_by(MaChuyen = get_route.MaChuyen).all()
        get_payment_list = app.db_session.query(phuongthucthanhtoan).all()
        get_cus_list = app.db_session.query(khachhang).all()
        data = []
        for ticket in get_ticket_list:
            for payment in get_payment_list:
                for cus in get_cus_list:
                    if ticket.MaVe == payment.MaVe:
                        if cus.MaKhachHang == payment.MaKhachHang:
                            data.append([serialize(ticket), serialize(payment), serialize(cus)])
        data_json = dumps({'data' : data}, default = str)
        resp = data_json
        return resp
    else:
        data_json = dumps({'data' : list}, default = str)
        resp = data_json
        return resp

#quản lý tuyến đường
@admin.route("/add_route")
@login_required
def add_route():
    get_bus = app.db_session.query(xebus).filter_by(TinhTrang = 0).all()
    get_driver = app.db_session.query(taixe).filter_by(TrangThai = 0).all()
    return render_template('admin/add_route.html', buses = get_bus, drivers = get_driver)    
@admin.route("/route_list")
@login_required
def route_list():
    return render_template('admin/route_list.html')  

#quản lý tài xế
@admin.route("/driver_list", methods=['GET'])
@login_required
def driver_list():
    return render_template('admin/driver_list.html')   
@admin.route("/add_new_driver", methods=['POST'])
@login_required
def add_new_driver():
    return render_template('admin/add_new_driver.html')   


#quản lý xe bus
@admin.route("/add_new_bus")
@login_required
def add_new_bus():
    return render_template('admin/add_new_bus.html')        
@admin.route("/bus_list")
@login_required
def bus_list():
    return render_template('admin/bus_list.html')    

@admin.route("/view_bus_detail/<int:id>", methods=['GET'])
@login_required
def view_bus_detail(id):
    get_bus = app.db_session.query(xebus).filter_by(MaXeBus = id).first()
    return render_template('admin/view_bus_detail.html', bus = get_bus)   


#quản lý người dùng  
@admin.route("/user_list")
@login_required
def user_list():
    return render_template('admin/user_list.html')   

@admin.route("/view_user_detail/<int:id>", methods=['GET'])
@login_required
def view_user_detail(id):
    user = app.db_session.query(nguoidung, khachhang).filter_by(nguoidung.MaNguoiDung == id).select_from(nguoidung).join(khachhang).first()
    ticket_list = app.db_session.query(datve)
    return render_template('admin/view_bus_detail.html', user = user, ticket_list = ticket_list)   

def serialize(model):
  """Transforms a model into a dictionary which can be dumped to JSON."""
  # first we get the names of all the columns on your model
  columns = [c.key for c in class_mapper(model.__class__).columns]
  # then we return their values in a dict
  return dict((c, getattr(model, c)) for c in columns)

#api
@admin.route('/add_bus_api', methods=['POST'])
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
        xb =  xebus(BienSoXe = _bs, LoaiXe = _lx, SoGhe = _sg, SoXe = _sx, TinhTrang = 0 )
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

@admin.route('/add_route_api', methods=['POST'])
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
    tx.TrangThai = 1 
    xb = app.db_session.query(xebus).filter_by(MaXeBus = bus).first()
    xb.TinhTrang = 1   
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


@admin.route('/add_driver_api', methods=['POST'])
def add_driver_api():
    _json = request.json
    _fname = _json['fname']
    _exp = _json['exp']
    _phone = _json['phone']
    _pw = _json['pw']	
    exist = bool(app.db_session.query(taixe).filter_by(SoDienThoai=_phone).first())
    if exist:
        resp = jsonify({'error' : True, 'message' : 'Số điện thoại đã tồn tại!'})
        return resp
    else:
        nd =  nguoidung(TaiKhoan = _phone, MatKhau = _pw, SoDienThoai = _phone, TrangThai = 1, NgayTao = datetime.now(),VaiTro = 1 )
        app.db_session.add(nd)
        app.db_session.commit()
        id = nd.MaNguoiDung
        tx =  taixe(MaNguoiDung = id, SoDienThoai = _phone, HoVaTen = _fname, KinhNghiem = _exp, TrangThai = 0 )
        app.db_session.add(tx)
        app.db_session.commit()
        resp = jsonify({'error' : False, 'message' : 'Thêm tài xế thành công!'})
        return resp

@admin.route('/update_bus_api', methods=['POST'])
def update_bus_api():
    _json = request.json
    _id = _json['id']
    _sx = _json['sx']
    _lx = _json['lx']
    _bs = _json['bs']	
    bus = app.db_session.query(xebus).filter_by(MaXeBus=_id).first()
    if (bus.BienSoXe != _bs):
        exist = bool(app.db_session.query(xebus).filter_by(BienSoXe=_bs).first())
        if exist:
            resp = jsonify({'error' : True, 'message' : 'Biển số xe đã tồn tại!'})
            return resp
        else:
            bus.BienSoXe = _bs
    bus.LoaiXe = _lx
    bus.SoXe = _sx
    app.db_session.commit()
    resp = jsonify({'error' : False, 'message' : 'Cập nhật thành công!'})
    return resp
@admin.route("/bus_list_api")
def bus_list_api():
    list = []
    bus_list = app.db_session.query(xebus).all()
    # we can then use this for your particular example
    list = [serialize(bus) for bus in bus_list]

    data_json = dumps({'data' : list})
    resp = data_json
    return resp

@admin.route("/route_list_api")
def route_list_api():
    list = []
    r_list = app.db_session.query(chuyenxe).all()
    # we can then use this for your particular example
    list = [serialize(cx) for cx in r_list]

    data_json = dumps({'data' : list}, default = str)
    resp = data_json
    return resp


@admin.route("/driver_list_api")
def driver_list_api():
    list = []
    driver_list = app.db_session.query(taixe).all()
    # we can then use this for your particular example
    list = [serialize(tx) for tx in driver_list]
    data_json = dumps({'data' : list})
    resp = data_json
    return resp

@admin.route("/user_list_api")
def user_list_api():
    results = app.db_session.query(nguoidung, khachhang).select_from(nguoidung).join(khachhang).all()
    for i in results:
        return_data.append({'SoDienThoai' : i.nguoidung.SoDienThoai, 'NgayTao' : i.nguoidung.NgayTao, 'VaiTro' : i.nguoidung.VaiTro, 'MaNguoiDung' : i.nguoidung.MaNguoiDung, 'HoVaTenKhachHang' : i.khachhang.HoVaTenKhachHang, 'DiaChi' : i.khachhang.DiaChi, 'CMND' : i.khachhang.CMND })
    return_data = jsonify({'data' : return_data})
    resp = return_data
    return resp


@admin.route("/ticket_verify", methods = ['GET'])
def ticket_verify():
    return render_template('admin/test_qr.html')

@admin.route("/ticket_detail", methods = ['GET'])
def ticket_detail():
    id = request.args.get('id')
    ve = app.db_session.query(datve).filter_by(MaVe=id).first()
    dsghe = app.db_session.query(lichsudatghe).filter_by(MaChuyen = ve.MaChuyen, NgayDat = ve.NgayDi).all()
    pttt = app.db_session.query(phuongthucthanhtoan).filter_by(MaVe= ve.MaVe).first()
    tuyen = app.db_session.query(chuyenxe).filter_by(MaChuyen = ve.MaChuyen).first()
    return render_template('admin/ticket_detail.html', tuyen = tuyen, ve = ve, pttt = pttt, dsghe = dsghe)




@admin.route("/login_page")
def login_page():
    return render_template('admin/login.html')
@admin.route("/logout")
def logout():
    if 'admin_id' in session:
        session.pop('admin_id')
    else:
        session.pop('driver_id')
    return redirect('/admin/login_page')
@admin.route("/login", methods = ['POST'])
def login():
    _json = request.json
    phone = _json['usn']
    pw = _json['pw']
    if phone and pw:
        exist = app.db_session.query(nguoidung).filter_by(SoDienThoai=phone, MatKhau = pw).filter((nguoidung.VaiTro ==3) | (nguoidung.VaiTro == 1)).first()
        if bool(exist):
            if exist.VaiTro == 3:
                session["admin_id"] = exist.MaNguoiDung
            else:
                session["driver_id"] = exist.MaNguoiDung
            session["role"] = exist.VaiTro
            session["p"] = exist.SoDienThoai
            resp = jsonify({'error' : 'false'})
            return resp
        else:
            resp = jsonify({'error' : 'true', 'message' : 'Số điện thoại hoặc mật khẩu không chính xác!'})
            return resp
    else:
        resp = jsonify({'error' : 'true', 'message' : 'Số điện thoại hoặc mật khẩu không được trống!'})
        return resp
    

@admin.route("/update_route_status_api", methods = ['POST'])
def update_route_status_api():
    _json = request.json
    id = _json['id']
    cx = app.db_session.query(chuyenxe).filter_by(MaChuyen = id).first()
    cx.TrangThai = 0 if cx.TrangThai == 1 else 1
    app.db_session.commit()
    resp = jsonify({'error' : 'false'})
    return resp
    



@admin.route("/test_qr")

def test_qr():
    
    return render_template('admin/test_qr.html')