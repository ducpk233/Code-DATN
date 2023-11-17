from datetime import timedelta
from flask import jsonify, render_template
from app import app, datve, dondangky, khachhang, lichsuve, lichsuvi, nguoidung, vethang, vinguoidung
from routes.admin.helper import  login_required, roles_required, serialize
from routes.admin import  *

#quản lý người dùng (khach hang)  
#page
@padmin.route("/user_list")
@login_required
@roles_required(3)
def user_list():
    return render_template('admin/user_list.html')   

@padmin.route("/customer_list")
@login_required
@roles_required("3", "2")
def customer_list():
    return render_template('admin/customer_list.html')   

@padmin.route("/customer_billing/<int:id>")
@login_required
@roles_required("3", "2")
def customer_billing(id):
    customer = app.db_session.query(nguoidung, khachhang).join(khachhang).filter(nguoidung.MaNguoiDung == id).first()
    #lịch sử đăng ký vé tháng
    reg_history = app.db_session.query(dondangky).filter(dondangky.MaKhachHang == customer.khachhang.MaKhachHang).all()
    #lấy vé tháng hiện có
    plan = app.db_session.query(vethang).filter(vethang.MaKhachHang == customer.khachhang.MaKhachHang).first()
    #lấy ds tuyến đq hoạt động
    routes = app.db_session.query(chuyenxe).filter(chuyenxe.TrangThai == 1).all()
    plan_history = None
    route = None
    diff = None
    current_date = datetime.now().date()
    if plan:
        diff = plan.NgayKetThuc- current_date
        diff = diff.days
        plan_history = app.db_session.query(lichsuve).filter(plan.MaVeThang == lichsuve.MaVeThang).order_by(lichsuve.Ngay.desc()).all()
        if plan.MaTuyenCoDinh:
            route = app.db_session.query(chuyenxe).filter(vethang.MaTuyenCoDinh == chuyenxe.MaChuyen).first()
    
    return render_template('admin/profile_detail/customer_billing.html', customer = customer, plan = plan , reg_history = reg_history, 
                           plan_history = plan_history, route = route, diff = diff, current_date = current_date,
                           routes = routes)  
from sqlalchemy.orm import aliased
@padmin.route("/customer_wallet/<int:id>")
@login_required
@roles_required("3", "2")
def customer_wallet(id):
    customer = app.db_session.query(nguoidung, khachhang).join(khachhang).filter(nguoidung.MaNguoiDung == id).first()
    DatVeAlias = aliased(datve)
    ChuyenXeAlias = aliased(chuyenxe)
    PhuongThucThanhToanAlias = aliased(phuongthucthanhtoan)

	# Lọc thông tin từ các bảng
    ticket_list = (
		app.db_session.query(DatVeAlias, ChuyenXeAlias, PhuongThucThanhToanAlias)
		.join(ChuyenXeAlias, DatVeAlias.MaChuyen == ChuyenXeAlias.MaChuyen)
		.join(PhuongThucThanhToanAlias, DatVeAlias.MaVe == PhuongThucThanhToanAlias.MaVe)
		.filter(DatVeAlias.MaKhachHang == customer.khachhang.MaKhachHang)
		.all()
	)
    print(ticket_list)
    return render_template('admin/profile_detail/customer_billing.html', customer = customer, ticket_list = ticket_list)  

@padmin.route("/customer_detail/<int:id>", methods=['GET'])
@login_required
@roles_required("3", "2")
def view_user_detail(id):
    customer = app.db_session.query(nguoidung, khachhang).join(khachhang).filter(nguoidung.MaNguoiDung == id).first()
    print(customer)
    DatVeAlias = aliased(datve)
    ChuyenXeAlias = aliased(chuyenxe)
    PhuongThucThanhToanAlias = aliased(phuongthucthanhtoan)

	# Lọc thông tin từ các bảng
    ticket_list = (
		app.db_session.query(DatVeAlias, ChuyenXeAlias, PhuongThucThanhToanAlias)
		.join(ChuyenXeAlias, DatVeAlias.MaChuyen == ChuyenXeAlias.MaChuyen)
		.join(PhuongThucThanhToanAlias, DatVeAlias.MaVe == PhuongThucThanhToanAlias.MaVe)
		.filter(DatVeAlias.MaKhachHang == customer.khachhang.MaKhachHang)
		.all()
	)
    print(ticket_list)
    return render_template('admin/profile_detail/customer_detail.html', customer = customer, ticket_list = ticket_list, )   

@padmin.route("/customer_security/<int:id>", methods=['GET'])
@login_required
@roles_required("3", "2")
def customer_security(id):
    customer = app.db_session.query(nguoidung, khachhang).join(khachhang).filter(nguoidung.MaNguoiDung == id).first()
    print(customer)
    ticket_list = app.db_session.query(datve).filter(datve.MaKhachHang == customer.khachhang.MaKhachHang).all()
    wallet = app.db_session.query(vinguoidung).filter(vinguoidung.MaNguoiDung == id).first()
    wallet_history = app.db_session.query(lichsuvi).filter(lichsuvi.MaVi == wallet.MaVi).all()
    return render_template('admin/profile_detail/security.html', customer = customer, ticket_list = ticket_list, wallet = wallet, wallet_history = wallet_history)   


@padmin.route("/add_new_customer", methods=['GET'])
@roles_required("3", "2")
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
#thêm khách hàng
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
        vi =  vinguoidung(MaNguoiDung = nd.MaNguoiDung, SoDu = 0 )
        app.db_session.add(vi)
        app.db_session.commit()
        resp = jsonify({'error' : False, 'message' : 'Thêm khách hàng thành công!'})
        return resp
#lấy thông tin khách hàng
@padmin.route("/get_customer_api/<int:id>", methods = ['GET'])
def get_customer_api(id): 
    
    us = app.db_session.query(nguoidung).filter_by(MaNguoiDung = id).first()
    cus = app.db_session.query(khachhang).filter_by(MaNguoiDung = us.MaNguoiDung).first()
    if cus and us:
        return jsonify({'error': False, 'data': {'user_info' : serialize(us) , 'cus_info' : serialize(cus)}})
    else:
        return jsonify({'error': True, 'message': 'Khách hàng không tồn tại. Vui lòng tải lại trang!'})
#cập nhật thông tin khách hàng
@padmin.route('/update_customer_api/<int:id>', methods=['POST'])
def update_customer_api(id):
 
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
#api cập nhật trạng thái khách hàng
@padmin.route('/update_customer_status_api/<int:id>', methods=['GET'])
def update_customer_status_api(id):
    user = app.db_session.query(nguoidung).filter_by(MaNguoiDung=id).first()
    if user:
        user.TrangThai = 1 if user.TrangThai == 0 else 0
        app.db_session.commit()
        return jsonify({'error' : False, 'message' : 'Cập nhật khách hàng thành công!'})
    else:
        return jsonify({'error' : True, 'message' : 'Khách hàng không tồn tại! Vui lòng tải lại trang'})
#api cập nhật trạng thái vé tháng
@padmin.route('/update_billing_status_api/<int:id>', methods=['GET'])
def update_billing_status_api(id):
    bl = app.db_session.query(vethang).filter_by(MaVeThang=id).first()
    if bl:
        bl.TrangThai = 1 if bl.TrangThai == 0 else 0
        evt = "Kích hoạt vé tháng" if  bl.TrangThai == 1 else "Khóa vé tháng"
        his = lichsuve(MaVeThang = id, SuKien = evt, Ngay = datetime.now())
        app.db_session.add(his)
        app.db_session.commit()
        return jsonify({'error' : False, 'message' : 'Cập nhật trạng thái vé tháng thành công!'})
    else:
        return jsonify({'error' : True, 'message' : 'Vé tháng không tồn tại! Vui lòng tải lại trang'})
    
#api thay gói vé tháng
@padmin.route('/change_billing_api', methods=['POST'])
def change_billing_api():
    _json = request.json
    _plan = _json['plan']
    _price = _json['price']
    _route_id = _json['route_id']
    _cus_id = _json['cus_id']
    _billing_id = _json['billing_id']
    if _billing_id:
        bl = app.db_session.query(vethang).filter_by(MaVeThang=_billing_id).first()
        bl.GoiDangKy = _plan
        bl.GiaVe = _price
        bl.MaTuyenCoDinh = _route_id
        evt = "Thay đổi gói vé tháng sang: " + _plan
        his = lichsuve(MaVeThang = _billing_id, SuKien = evt, Ngay = datetime.now())
        app.db_session.add(his)
        app.db_session.commit()
        return jsonify({'error' : False, 'message' : 'Thay đổi gói vé tháng thành công!'})
    else:
        bl = vethang(MaKhachHang = _cus_id, GoiDangKy = _plan, MaTuyenCoDinh = _route_id, GiaVe = _price, TrangThai = 1, NgayBatDau = datetime.now().date(), NgayKetThuc = datetime.now().date() + timedelta(days=30))
        app.db_session.add(bl)
        app.db_session.commit()
        return jsonify({'error' : False, 'message' : 'Đăng ký vé tháng thành công!'})
#api gia hạn vé tháng
@padmin.route('/change_date_billing_api/<int:id>', methods=['POST'])
def change_date_billing_api(id):
    _json = request.json
    _days = _json['day']
    bl = app.db_session.query(vethang).filter_by(MaVeThang=id).first()
    if bl:
        bl.NgayKetThuc = _days 
        evt = "Cập nhật ngày kết thúc vé tháng: " + str(_days)
        his = lichsuve(MaVeThang = id, SuKien = evt, Ngay = datetime.now())
        app.db_session.add(his)
        app.db_session.commit()
        return jsonify({'error' : False, 'message' : 'Cập nhật ngày vé tháng thành công!'})
    else:
        return jsonify({'error' : True, 'message' : 'Vé tháng không tồn tại! Vui lòng tải lại trang'})