from flask import jsonify, render_template
from app import app, datve, khachhang, nguoidung
from routes.admin.helper import  login_required, serialize
from routes.admin import  *

#quản lý người dùng (khach hang)  
#page
@padmin.route("/user_list")
@login_required
def user_list():
    return render_template('admin/user_list.html')   

@padmin.route("/customer_list")
@login_required
def customer_list():
    return render_template('admin/customer_list.html')   


@padmin.route("/view_user_detail/<int:id>", methods=['GET'])
@login_required
def view_user_detail(id):
    user = app.db_session.query(nguoidung, khachhang).filter_by(nguoidung.MaNguoiDung == id).select_from(nguoidung).join(khachhang).first()
    ticket_list = app.db_session.query(datve)
    return render_template('admin/view_bus_detail.html', user = user, ticket_list = ticket_list)   

@padmin.route("/add_new_customer", methods=['GET'])
@login_required
def add_new_customer():
    return render_template('admin/add_new_customer.html')   

#api
@padmin.route("/user_list_api")
def user_list_api():
    return_data = []
    results = app.db_session.query(nguoidung, khachhang).select_from(nguoidung).filter_by(VaiTro=0).join(khachhang).all()
    for i in results:
        return_data.append({'SoDienThoai' : i.nguoidung.SoDienThoai, 'NgayTao' : i.nguoidung.NgayTao, 'VaiTro' : i.nguoidung.VaiTro, 'MaNguoiDung' : i.nguoidung.MaNguoiDung, 'HoVaTenKhachHang' : i.khachhang.HoVaTenKhachHang, 'DiaChi' : i.khachhang.DiaChi, 'CMND' : i.khachhang.CMND, 'TrangThai' : i.nguoidung.TrangThai })
    return_data = jsonify({'data' : return_data})
    resp = return_data
    return resp

@padmin.route("/del_customer_api", methods = ['POST'])
def del_customer_api():
    _json = request.json
    id = _json['id']
    print(id)
    
    usr = app.db_session.query(nguoidung).filter_by(MaNguoiDung = id).first()
    if usr != None:
        b = app.db_session.query(khachhang).filter_by(MaNguoiDung = usr.MaNguoiDung).first()
        app.db_session.delete(usr)
        app.db_session.delete(b)
        app.db_session.commit()
        return jsonify({'error': False, 'message': 'Đã xóa thành công!'})
    else:
        return jsonify({'error': True, 'message': 'Khách hàng không tồn tại. Vui lòng tải lại trang!'})

#api
@padmin.route('/add_customer_api', methods=['POST'])
def add_customer_api():
    _json = request.json
    _fname = _json['fname']
    _addr = _json['addr']
    _phone = _json['phone']
    _pw = _json['pw']
    _dmail = _json['dmail']	
    _cmnd = _json['cmnd']	

    	
    exist = bool(app.db_session.query(nguoidung).filter_by(TaiKhoan=_dmail).first())
    if exist:
        resp = jsonify({'error' : True, 'message' : 'Email đã tồn tại!'})
        return resp
    else:
        nd =  nguoidung(TaiKhoan = _dmail, MatKhau = _pw, SoDienThoai = _phone, TrangThai = 1, NgayTao = datetime.now(), VaiTro = 0 )
        app.db_session.add(nd)
        app.db_session.commit()
        id = nd.MaNguoiDung
        kh =  khachhang(MaNguoiDung = id, SoDienThoai = _phone, HoVaTenKhachHang = _fname, DiaChi = _addr, CMND = _cmnd )
        app.db_session.add(kh)
        app.db_session.commit()
        resp = jsonify({'error' : False, 'message' : 'Thêm tài xế thành công!'})
        return resp
    
@padmin.route("/get_customer_api/<int:id>", methods = ['GET'])
def get_customer_api(id): 
    
    us = app.db_session.query(nguoidung).filter_by(MaNguoiDung = id).first()
    cus = app.db_session.query(khachhang).filter_by(MaNguoiDung = us.MaNguoiDung).first()
    if cus and us:
        return jsonify({'error': False, 'data': {'user_info' : serialize(us) , 'cus_info' : serialize(cus)}})
    else:
        return jsonify({'error': True, 'message': 'Khách hàng không tồn tại. Vui lòng tải lại trang!'})
    
@padmin.route('/update_customer_api/<int:id>', methods=['POST'])
def update_customer_api(id):
 
    _json = request.json
    _json = request.json
    _fname = _json['fname']
    _addr = _json['addr']
    _phone = _json['phone']
    _pw = _json['pw']
    _dmail = _json['dmail']	
    _cmnd = _json['cmnd']	
	
    _status = int(_json['status'])	

    user = app.db_session.query(nguoidung).filter_by(MaNguoiDung=id).first()
    if user:
        cus = app.db_session.query(khachhang).filter_by(MaNguoiDung = user.MaNguoiDung).first()
        cus.CMND = _cmnd
        cus.HoVaTenKhachHang = _fname
        cus.DiaChi = _addr
        cus.SoDienThoai = _phone

        user.SoDienThoai = _phone
        user.MatKhau = _pw
        user.TrangThai = int(_status)
        if (_dmail.strip() != user.TaiKhoan):
            exist = bool(app.db_session.query(nguoidung).filter_by(TaiKhoan=_dmail).first())
            if exist:
                resp = jsonify({'error' : True, 'message' : 'Email đã tồn tại!'})
                return resp
            else:
                user.TaiKhoan = _dmail
        app.db_session.commit()
        return jsonify({'error' : False, 'message' : 'Cập nhật khách hàng thành công!'})
    else:
        return jsonify({'error' : True, 'message' : 'Khách hàng không tồn tại! Vui lòng tải lại trang'})