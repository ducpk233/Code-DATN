from json import dumps
from flask import jsonify, render_template, request, session
from routes.admin.helper import login_required, roles_required, serialize
from app import app, chuyenxe, datve, dondangky, khachhang, lichsudatghe, lichsuve, nguoidung, phuongthucthanhtoan, taixe, vethang
from datetime import datetime
from routes.admin import  *

#quản lý tài xế
#page
@padmin.route("/driver_ticket_list")
@login_required
@roles_required("1")
def driver_ticket_list():
    
    return render_template('admin/driver_ticket_list.html')  

@padmin.route("/driver_list", methods=['GET'])
@login_required
@roles_required("3")
def driver_list():
    return render_template('admin/driver_list.html')   

@padmin.route("/add_new_driver", methods=['GET'])
@login_required
@roles_required("3")
def add_new_driver():
    return render_template('admin/add_new_driver.html')   

@padmin.route("/ticket_verify", methods = ['GET'])
@login_required
@roles_required("1")
def ticket_verify():
    return render_template('admin/test_qr.html')

@padmin.route("/monthly_verify", methods = ['GET'])
@login_required
@roles_required("1")
def monthly_verify():
    return render_template('admin/test_qr_monthly.html')

from sqlalchemy.orm import aliased
@padmin.route("/ticket_detail", methods = ['GET'])
@login_required
def ticket_detail():
	id = request.args.get("id")
	# Tạo các alias cho các bảng
	DatVeAlias = aliased(datve)
	ChuyenXeAlias = aliased(chuyenxe)
	PhuongThucThanhToanAlias = aliased(phuongthucthanhtoan)
	
	ticket = (
		app.db_session.query(DatVeAlias, ChuyenXeAlias, PhuongThucThanhToanAlias)
		.join(ChuyenXeAlias, DatVeAlias.MaChuyen == ChuyenXeAlias.MaChuyen)
		.join(PhuongThucThanhToanAlias, DatVeAlias.MaVe == PhuongThucThanhToanAlias.MaVe)
		.filter(DatVeAlias.MaVe == id)
		.first()
	)
	taken_seat = app.db_session.query(lichsudatghe).filter_by(MaVe=id).all()	
	now = datetime.now().date()
	
	return render_template('admin/ticket_detail.html', ticket = ticket, fmt_now = now, taken_seat = taken_seat)

@padmin.route("/monthly_ticket_detail", methods = ['GET'])
@login_required
def monthly_ticket_detail():
    id = request.args.get("id")
	#lấy vé tháng
    plan = app.db_session.query(vethang).filter(vethang.MaVeThang == id).first()
    cus_info = app.db_session.query(khachhang).filter(khachhang.MaKhachHang == plan.MaKhachHang).first()
    customer = app.db_session.query(nguoidung, khachhang).join(khachhang).filter(nguoidung.MaNguoiDung == cus_info.MaNguoiDung).first()
    #lấy ds tuyến đq hoạt động
    routes = app.db_session.query(chuyenxe).filter(chuyenxe.TrangThai == 1).all()
    plan_history = None
    route = None
    diff = None
    current_date = datetime.now().date()
    if plan:
        diff = plan.NgayKetThuc- current_date
        diff = diff.days
        
        if plan.MaTuyenCoDinh:
            route = app.db_session.query(chuyenxe).filter(vethang.MaTuyenCoDinh == chuyenxe.MaChuyen).first()
    
    return render_template('admin/monthly-ticket-detail.html', customer = customer, plan = plan , 
                            route = route, diff = diff, current_date = current_date,
                           routes = routes)


#api
@padmin.route('/add_driver_api', methods=['POST'])
def add_driver_api():
    _json = request.json
    _fname = _json['fname']
    _exp = _json['exp']
    _phone = _json['phone']
    _pw = _json['pw']
    _dmail = _json['dmail']		
    exist = bool(app.db_session.query(nguoidung).filter_by(TaiKhoan=_dmail).first())
    if exist:
        resp = jsonify({'error' : True, 'message' : 'Email đã tồn tại!'})
        return resp
    else:
        nd =  nguoidung(TaiKhoan = _dmail, MatKhau = _pw, SoDienThoai = _phone, TrangThai = 1, NgayTao = datetime.now(),VaiTro = 1 )
        app.db_session.add(nd)
        app.db_session.commit()
        id = nd.MaNguoiDung
        tx =  taixe(MaNguoiDung = id, SoDienThoai = _phone, HoVaTen = _fname, KinhNghiem = _exp, TrangThai = 1 )
        app.db_session.add(tx)
        app.db_session.commit()
        resp = jsonify({'error' : False, 'message' : 'Thêm tài xế thành công!'})
        return resp

@padmin.route("/driver_list_api")
def driver_list_api():
    list = []
    driver_list = app.db_session.query(taixe).all()
    # we can then use this for your particular example
    list = [serialize(tx) for tx in driver_list]
    data_json = dumps({'data' : list})
    resp = data_json
    return resp

@padmin.route("/driver_ticket_list_api")
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

@padmin.route("/del_driver_api", methods = ['POST'])
def del_driver_api():
    _json = request.json
    id = _json['id']
    b = app.db_session.query(taixe).filter_by(MaTaiXe = id).first()
    if b:
        usr = app.db_session.query(nguoidung).filter_by(MaNguoiDung = b.MaNguoiDung).first()
        app.db_session.delete(usr)
        app.db_session.delete(b)
        app.db_session.commit()
        return jsonify({'error': False, 'message': 'Đã xóa thành công!'})
    else:
        return jsonify({'error': True, 'message': 'Tài xế không tồn tại. Vui lòng tải lại trang!'})
    
@padmin.route("/get_driver_api/<int:id>", methods = ['GET'])
def get_driver_api(id): 
    drv = app.db_session.query(taixe).filter_by(MaTaiXe = id).first()
    us = app.db_session.query(nguoidung).filter_by(MaNguoiDung = drv.MaNguoiDung).first()
    if drv and us:
        return jsonify({'error': False, 'data': {'user_info' : serialize(us) , 'driver_info' : serialize(drv)}})
    else:
        return jsonify({'error': True, 'message': 'Tài xế không tồn tại. Vui lòng tải lại trang!'})
    
@padmin.route('/update_driver_api/<int:id>', methods=['POST'])
def update_driver_api(id):
 
    _json = request.json
    _fname = _json['fname']
    _exp = _json['exp']
    _phone = _json['phone']
    _pw = _json['pw']
    _dmail = _json['dmail']		
    _status = int(_json['status'])	

    driver = app.db_session.query(taixe).filter_by(MaTaiXe=id).first()
    driver.KinhNghiem = _exp
    driver.HoVaTen = _fname
    driver.TrangThai = _status
    user = app.db_session.query(nguoidung).filter_by(MaNguoiDung=driver.MaNguoiDung).first()
    user.SoDienThoai = _phone
    user.MatKhau = _pw
    if (_dmail.strip() != user.TaiKhoan):
        exist = bool(app.db_session.query(nguoidung).filter_by(TaiKhoan=_dmail).first())
        if exist:
            resp = jsonify({'error' : True, 'message' : 'Email đã tồn tại!'})
            return resp
        else:
            user.TaiKhoan = _dmail
    app.db_session.commit()
    return jsonify({'error' : False, 'message' : 'Cập nhật tài xế thành công!'})
    
#xác nhận vé thừuong
@padmin.route("/confirm_normal_ticket_api", methods=['POST'])
def confirm_normal_ticket_api():
    id  = request.json['id']
    tick = app.db_session.query(datve).filter_by(MaVe = id).first()
    pay = app.db_session.query(phuongthucthanhtoan).filter_by(MaVe = id).first()
    now = datetime.now().date()
    if tick.TrangThai == 2 or tick.TrangThai == 0:
        return jsonify({'error' : True, 'message' : 'Vé đã được sử dụng hoặc đã hủy!'})
    elif tick.NgayDi < now or tick.NgayDi > now:
        return jsonify({'error' : True, 'message' : 'Vé đang xác nhận đang trước hoặc quá ngày đi!'})
    
    else:
        tick.TrangThai = 2
        pay.TrangThai = 1
        resp = {'error' : False, 'message' : 'Xác nhận vé thành công'}
        app.db_session.commit()
        return resp
    
#xác nhận vé tháng
@padmin.route("/confirm_monthly_ticket_api", methods=['POST'])
def confirm_monthly_ticket_api():
    id  = request.json['id']
    bl = app.db_session.query(vethang).filter_by(MaVeThang=id).first()
    
    now = datetime.now().date()
    if bl.TrangThai == 0:
        return jsonify({'error' : True, 'message' : 'Vé tháng đã bị khóa!'})
    elif bl.NgayKetThuc < now :
        return jsonify({'error' : True, 'message' : 'Vé tháng đã hết hạn!'})
    else:
        his = lichsuve(MaVeThang = id, SuKien = "Sử dụng vé tháng trên xe bus.", Ngay = datetime.now())
        app.db_session.add(his)
        
        app.db_session.commit()
        resp = {'error' : False, 'message' : 'Xác nhận vé thành công'}
        return resp