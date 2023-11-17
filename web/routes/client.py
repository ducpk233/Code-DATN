
from functools import wraps
from http import client
from json import dumps
from lib2to3.pgen2 import driver
from flask_qrcode import QRcode
from sqlalchemy import false
from app import app, chuyenxe, datve, lichsudatghe, lichsuvi, lotrinh, nguoidung, khachhang, phuongthucthanhtoan, taixe, vinguoidung, xebus
from flask import Blueprint, redirect, render_template, session, url_for
from datetime import datetime
from flask import jsonify, request, flash
import database as db
from datetime import datetime
from sqlalchemy.orm import scoped_session, sessionmaker, Query
from sqlalchemy.orm import joinedload
from routes.admin.helper import serialize

from werkzeug.utils import secure_filename
import os
from vnpay_config import settings

from vnpay_config.vnpay import vnpay

client = Blueprint('client', __name__)


def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get('id') is None:
            return redirect(url_for('client.login'))
        return f(*args, **kwargs)
    return decorated_function

@client .route('/')
def welcome():
	bg_point = []
	get_route = app.db_session.query(chuyenxe).filter_by(TrangThai = 1).all()
	bg_point = list(set([item.DiemBatDau for item in get_route]))
	unique_bg_point = app.db_session.query(lotrinh.TenDiem).distinct().all()

	return render_template('mindex.html', bg_point = [item[0] for item in unique_bg_point])
	

	
@client .route('/logout')
def logout():
	session.clear()
	return redirect(url_for('client.welcome'))
#đăng nhập
@client .route('/login', methods=['POST', 'GET'])
def login():
	if request.method == 'POST': 
		email = request.form["email"]
		pw = request.form["password"]
		if email and pw:
			exist = app.db_session.query(nguoidung).filter_by(TaiKhoan=email, MatKhau = pw, VaiTro = 0).first()
			if bool(exist):
				session.clear()
				session["id"] = exist.MaNguoiDung
				if exist.TrangThai == 0:
					flash("Tài khoản đã bị vô hiệu hóa. Vui lòng liên hệ tổng đài để được hỗ trợ!")
				else:
					return redirect(url_for('client.home'))
				
			else:
				flash("Email hoặc mật khẩu không chính xác!")
		else:
			flash('Email hoặc mật khẩu không được trống!')
	return render_template('login.html')

#đăng ký
@client.route('/register',  methods=['POST', 'GET'])
def register():
	if request.method == 'POST': 
		
		fname = request.form["fname"]
		lname = request.form["lname"]
		email = request.form["email"]
		phone = request.form["phone"]
		pw = request.form["password"]
		rtpw = request.form["confirm_pw"]
		exist = bool(app.db_session.query(nguoidung).filter_by(TaiKhoan=email).first())
		if exist:
			flash('Email đã được đăng ký!')
		else:
			if phone and pw and rtpw:
				if pw != rtpw:
					flash('Nhập lại mật khẩu không chính xác')
				else:
					nd =  nguoidung(TaiKhoan = email, MatKhau = pw, SoDienThoai = phone, TrangThai = 1, NgayTao = datetime.now(),VaiTro = 0 )
					app.db_session.add(nd)
					app.db_session.commit()
					kh =  khachhang(MaNguoiDung = nd.MaNguoiDung, SoDienThoai = phone, HoVaTenKhachHang = lname + ' ' + fname )
					app.db_session.add(kh)
					vi =  vinguoidung(MaNguoiDung = nd.MaNguoiDung, SoDu = 0 )
					app.db_session.add(vi)
					app.db_session.commit()
					return redirect(url_for('client.login'))
			else:
				flash("Vui lòng nhập đủ họ và tên, email, số điện thoại, mật khẩu và xác nhận mật khẩu!")
	return render_template('register.html')


@client.route('/home')
def home():
	bg_point = []
	get_route = app.db_session.query(chuyenxe).filter_by(TrangThai = 1).all()
	bg_point = list(set([item.DiemBatDau for item in get_route]))
	unique_bg_point = app.db_session.query(lotrinh.TenDiem).distinct().all()

	return render_template('mindex.html', bg_point = [item[0] for item in unique_bg_point])
from sqlalchemy.orm import aliased
#trang đặt vé 	
@client.route('/my_ticket')
def my_ticket():
	id = session['id']
	kh = app.db_session.query(khachhang).filter_by(MaNguoiDung=id).first()	
	DatVeAlias = aliased(datve)
	ChuyenXeAlias = aliased(chuyenxe)
	PhuongThucThanhToanAlias = aliased(phuongthucthanhtoan)

	# Lọc thông tin từ các bảng
	result = (
		app.db_session.query(DatVeAlias, ChuyenXeAlias, PhuongThucThanhToanAlias)
		.join(ChuyenXeAlias, DatVeAlias.MaChuyen == ChuyenXeAlias.MaChuyen)
		.join(PhuongThucThanhToanAlias, DatVeAlias.MaVe == PhuongThucThanhToanAlias.MaVe)
		.filter(DatVeAlias.MaKhachHang == kh.MaKhachHang)
		.all()
	)
	
	return render_template('my-ticket.html', tickets = result)

#chi tiết vé
#nhận vào id, trả về thông tin vé
@client.route('/ticket_detail')
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
	
	return render_template('ticket-detail.html', ticket = ticket, fmt_now = now, taken_seat = taken_seat)

#profile
@client.route('/profile')
@login_required
def profile():
		
	return render_template('profile.html')

#trang thông tin tài khoản
@client.route('/profile_update', methods=['POST', 'GET'])
@login_required
def profile_update():
	id = session['id']
	user= app.db_session.query(nguoidung).filter_by(MaNguoiDung=id).first()	
	user_info = app.db_session.query(khachhang).filter_by(MaNguoiDung=id).first()	
	if request.method == 'POST': 
		name = request.form["fullname"]
		address = request.form["add"]
		phone = request.form["phone"]
		nation_id = request.form["natid"]
		user_info.HoVaTenKhachHang = name
		user_info.DiaChi = address
		user_info.CMND = nation_id
		user.SoDienThoai = phone
		user_info.SoDienThoai = phone

		#Lưu ảnh
		if 'user_image' in request.files:
			image = request.files['user_image']
			if image.filename != '':
				unique_filename = generate_unique_filename(image.filename)
				file_path = os.path.join('static/uploads', unique_filename)
				image.save(file_path)
				user_info.AnhDaiDien = unique_filename
		app.db_session.commit()
		flash('Cập nhật thành công!')
	return render_template('profile_update.html', get_user = user, get_user_info = user_info)
	
@client.route('/contact')
def contact():
	return render_template('contact.html')
	
@client.route('/notification')
def notification():
	return render_template('notification.html')	

@client.route('/select_seat', methods=['GET'])
def select_seat():
	id = request.args.get("id")
	date = request.args.get("date")
	route = app.db_session.query(chuyenxe).filter_by(MaChuyen = id).first()
	busid  = route.MaXeBus
	driverid  = route.MaTaiXe
	bus = app.db_session.query(xebus).filter_by(MaXeBus = busid).first()
	driver = app.db_session.query(taixe).filter_by(MaTaiXe = driverid).first()
	path = app.db_session.query(lotrinh).filter_by(MaChuyen = route.MaChuyen).all()
	return render_template('select-seat.html', route = route, bus = bus, driver = driver, path = path, date = date)	


@client.route('/select_route', methods=['GET'])
def select_route():
	bg_point = request.args.get('bg_point').strip()

	arr_point = request.args.get('arr_point').strip()

	date = request.args.get('date')

	bg_point_list = app.db_session.query(lotrinh).filter(lotrinh.TenDiem.ilike(bg_point)).all()
	
	end_point_list = app.db_session.query(lotrinh).filter(lotrinh.TenDiem.ilike(arr_point)).all()
	avai_route = []
	exist = []
	for diembatdau in bg_point_list:
		for diemketthuc in end_point_list:
			if diembatdau.MaChuyen == diemketthuc.MaChuyen:
				if diembatdau.MaChuyen not in (item['route_id'] for item in exist):
					route_info = app.db_session.query(chuyenxe).filter(chuyenxe.MaChuyen == diembatdau.MaChuyen).first()
					avai_route.append(route_info)
					exist.append({'route_id' : diembatdau.MaChuyen, 'route_string' : get_route_string(diembatdau.MaChuyen)}) if diembatdau.MaChuyen not in exist else None 
	print(exist)
	
	return render_template('select-route.html', route = avai_route, bg_point = bg_point, arr_point = arr_point, route_string = exist, date = date)	

def get_route_string(route_id):
    route_info = app.db_session.query(lotrinh). \
        join(chuyenxe, lotrinh.MaChuyen == chuyenxe.MaChuyen). \
        filter(chuyenxe.MaChuyen == route_id). \
        order_by(lotrinh.ThuTu).all()

    if route_info:
        route_list = [point.TenDiem for point in route_info]
        route_string = ' -> '.join(route_list)
        return route_string
    else:
        return None

@client.route('/wallet')
def wallet():
	user_id = session['id']
	wallet = app.db_session.query(vinguoidung).filter_by(MaNguoiDung = user_id).first()
	wallet_hist = app.db_session.query(lichsuvi).filter_by(MaVi = wallet.MaVi).all()
	return render_template('wallet.html', wallet = wallet, wallet_hist = wallet_hist)	


@client.route('/payment_return')
def payment_return():
	user_id = session['id']
	input_data = request.args
	if input_data:
		vnp = vnpay()  # Thay bằng tên class VnPay của bạn
		vnp.responseData = dict(input_data)
		
		order_id = input_data['vnp_TxnRef']
		
		amount = int(input_data['vnp_Amount']) / 100
		order_desc = input_data['vnp_OrderInfo']
		vnp_transaction_no = input_data['vnp_TransactionNo']
		vnp_response_code = input_data['vnp_ResponseCode']
		vnp_tmn_code = input_data['vnp_TmnCode']
		vnp_pay_date = input_data['vnp_PayDate']
		vnp_bank_code = input_data['vnp_BankCode']
		vnp_card_type = input_data['vnp_CardType']
		payment_processed_key = f'payment_processed_{vnp_transaction_no}'
		# Check if payment has already been processed in this session
		if session.get(payment_processed_key):
			return render_template("payment-return.html", title="Kết quả thanh toán",
                                   result="Đã xử lý trước đó", order_id=order_id, amount=amount,
                                   order_desc=order_desc, vnp_transaction_no=vnp_transaction_no,
                                   vnp_response_code=vnp_response_code)
		if vnp.validate_response(settings.VNPAY_HASH_SECRET_KEY):  # Thay bằng khóa bí mật của bạn
			if vnp_response_code == "00":
				#cập nhật lại thanh toán
				if order_desc == "Nạp thêm tiền vào ví cá nhân":
					wallet = app.db_session.query(vinguoidung).filter_by(MaNguoiDung = user_id).first()
					wallet.SoDu = wallet.SoDu + int(amount)
					wallet_his = lichsuvi(MaVi = wallet.MaVi, TenGiaoDich = 'Nạp tiền từ VNPAY. +' + str(amount) + 'đ' , NgayGiaoDich = datetime.now(), SoTien = amount)
					app.db_session.add(wallet_his)
					app.db_session.commit()
					session[f'payment_processed_{vnp_transaction_no}'] = True
				else:

					payment = app.db_session.query(phuongthucthanhtoan).filter_by(MaVe = order_id).first()
					payment.TrangThai = 1
					payment.NgayThanhToan = datetime.now()
					payment.PhuongThucThanhToan = 1
					app.db_session.commit()
					session[f'payment_processed_{vnp_transaction_no}'] = True
				return render_template("payment-return.html", title="Kết quả thanh toán",
                                       result="Thành công", order_id=order_id, amount=amount,
                                       order_desc=order_desc, vnp_transaction_no=vnp_transaction_no,
                                       vnp_response_code=vnp_response_code)
			else:
				return render_template("payment-return.html", title="Kết quả thanh toán",
                                       result="Lỗi", order_id=order_id, amount=amount,
                                       order_desc=order_desc, vnp_transaction_no=vnp_transaction_no,
                                       vnp_response_code=vnp_response_code)
		else:
			return render_template("payment-return.html", title="Kết quả thanh toán",
                                   result="Lỗi", order_id=order_id, amount=amount,
                                   order_desc=order_desc, vnp_transaction_no=vnp_transaction_no,
                                   vnp_response_code=vnp_response_code, msg="Sai checksum")
	else:
		return render_template("payment-return.html", title="Kết quả thanh toán", result="")

#api
@client.route("/build_vnpay_url", methods=['POST'])
def build_vnpay_url():
	
	od_desc  = request.json['desc']
	
	od_id  = request.json['id']
	od_amount  = int(request.json['amount'])
	#ipaddr = get_client_ip(request)
	# Build URL Payment
	vnp = vnpay()
	vnp.requestData['vnp_Version'] = '2.1.0'
	vnp.requestData['vnp_Command'] = 'pay'
	vnp.requestData['vnp_TmnCode'] = settings.VNPAY_TMN_CODE
	vnp.requestData['vnp_Amount'] = od_amount * 100
	vnp.requestData['vnp_CurrCode'] = 'VND'
	vnp.requestData['vnp_TxnRef'] = od_id
	vnp.requestData['vnp_OrderInfo'] = od_desc
	vnp.requestData['vnp_OrderType'] = 'billpayment'
	vnp.requestData['vnp_Locale'] = 'vn'
	vnp.requestData['vnp_CreateDate'] = datetime.now().strftime('%Y%m%d%H%M%S')  # 20150410063022
	vnp.requestData['vnp_IpAddr'] = "127.0.0.1"
	vnp.requestData['vnp_ReturnUrl'] = settings.VNPAY_RETURN_URL
	vnpay_payment_url = vnp.get_payment_url(settings.VNPAY_PAYMENT_URL, settings.VNPAY_HASH_SECRET_KEY)
	print(vnpay_payment_url)
	return jsonify(vnpay_payment_url)
import random
@client.route("/add_fund_build_url", methods=['POST'])
def add_fund_build_url():
	
	od_id  = random.sample(range(1,100), 6)
	od_amount  = int(request.json['amount'])
	#ipaddr = get_client_ip(request)
	# Build URL Payment
	vnp = vnpay()
	vnp.requestData['vnp_Version'] = '2.1.0'
	vnp.requestData['vnp_Command'] = 'pay'
	vnp.requestData['vnp_TmnCode'] = settings.VNPAY_TMN_CODE
	vnp.requestData['vnp_Amount'] = od_amount * 100
	vnp.requestData['vnp_CurrCode'] = 'VND'
	vnp.requestData['vnp_TxnRef'] = od_id
	vnp.requestData['vnp_OrderInfo'] = "Nạp thêm tiền vào ví cá nhân"
	vnp.requestData['vnp_OrderType'] = 'billpayment'
	vnp.requestData['vnp_Locale'] = 'vn'
	vnp.requestData['vnp_CreateDate'] = datetime.now().strftime('%Y%m%d%H%M%S')  # 20150410063022
	vnp.requestData['vnp_IpAddr'] = "127.0.0.1"
	vnp.requestData['vnp_ReturnUrl'] = settings.VNPAY_RETURN_URL + "?type=add_fund"
	vnpay_payment_url = vnp.get_payment_url(settings.VNPAY_PAYMENT_URL, settings.VNPAY_HASH_SECRET_KEY)
	print(vnpay_payment_url)
	return jsonify(vnpay_payment_url)


@client.route("/pay_with_wallet", methods=['POST'])
def pay_with_wallet():
	user_id  = session['id']
	id  = request.json['ticket_id']
	
	ticket = app.db_session.query(datve).filter_by(MaVe = id).first()
	ticket_payment = app.db_session.query(phuongthucthanhtoan).filter_by(MaVe = id).first()
	wallet = app.db_session.query(vinguoidung).filter_by(MaNguoiDung = user_id).first()
	if wallet.SoDu > ticket_payment.SoTien:
		#cập nhật lại số dư ví, số tiền còn lại trong ví = số dư - giá vé
		wallet.SoDu = wallet.SoDu - ticket_payment.SoTien
		ticket_payment.TrangThai = 1
		ticket_payment.PhuongThucThanhToan = 2
		now = datetime.now().date()
		wallet_his = lichsuvi(MaVi = wallet.MaVi, TenGiaoDich = 'Thanh toán cho vé có mã ' + str(ticket.MaVe) + '. -' + str(ticket_payment.SoTien) + 'đ' , NgayGiaoDich = datetime.now(), SoTien = ticket_payment.SoTien)
		app.db_session.add(wallet_his)
		app.db_session.commit()
		return jsonify({'error' : False, 'message' : 'Đã thanh toán bằng ví thành công!'})
	else:
		return jsonify({'error' : True, 'message' : 'Số dư ví không đủ! Vui lòng nạp thêm để tiếp tục'})


@client.route("/get_arr_point_api", methods=['POST'])
def get_arr_point_api():
    bgp  = request.json['bg']
    endp = []
    matching_route = get_matching_route(bgp)
    for ma_tuyen in matching_route:
        diem_tras = app.db_session.query(lotrinh.TenDiem).filter(lotrinh.MaChuyen == ma_tuyen, lotrinh.TenDiem != bgp).distinct().all()
        endp.extend([item[0] for item in diem_tras])

    unique_endp = list(set(endp))
    return unique_endp


@client.route("/cancel_ticket_api", methods=['POST'])
def cancel_ticket_api():
	user_id  = session['id']
	id  = request.json['id']
	
	tick = app.db_session.query(datve).filter_by(MaVe = id).first()
	pay = app.db_session.query(phuongthucthanhtoan).filter_by(MaVe = id).first()
	now = datetime.now().date()
	if tick.NgayDi < now:
		return jsonify({'message' : 'Vẽ đã quá hạn không thể hủy!'})
	else:
		tick.TrangThai = 0
		seat_hist = app.db_session.query(lichsudatghe).filter_by(MaVe = id).delete()
		if pay.TrangThai == 1:
			pay.TrangThai = 2
			print(pay.TrangThai)
			wallet = app.db_session.query(vinguoidung).filter_by(MaNguoiDung = user_id).first()
			wallet.SoDu = wallet.SoDu + pay.SoTien*0.9
			wallet_his = lichsuvi(MaVi = wallet.MaVi, TenGiaoDich = 'Hoàn tiền cho việc hủy vé có mã ' + str(tick.MaVe) + '. +' + str(pay.SoTien*0.9) + 'đ' , NgayGiaoDich = datetime.now(), SoTien = pay.SoTien)
			app.db_session.add(wallet_his)
			resp = {'error' : False, 'message' : 'Đã hủy vé thành công! Số tiền đã thanh toán sẽ được hoàn lại vào trong ví. Vui lòng kiểm tra'}
		else:
			resp = {'error' : False, 'message' : 'Đã hủy vé thành công!'}
		app.db_session.commit()
		return resp

@client.route("/book_ticket_api", methods=['POST'])
def book_ticket_api():
	seats  = request.json['seat']
	route_id  = request.json['route_id']
	bg_point_name  = request.json['bg_point_name']
	user_id  = session["id"]

	get_customer = app.db_session.query(khachhang).filter_by(MaNguoiDung = user_id).first()
	total  = request.json['total']
	date = request.json['date']
	vx = datve(NgayDat = datetime.now(), MaChuyen = route_id, MaKhachHang = get_customer.MaKhachHang, TrangThai = 1, NgayDi = date, DiemDon = bg_point_name)
	app.db_session.add(vx)
	app.db_session.commit()
	ticket_id = vx.MaVe
	pttt = phuongthucthanhtoan(MaKhachHang = get_customer.MaKhachHang, MaVe = ticket_id, PhuongThucThanhToan = 0, TrangThai = 0, SoTien = total)
	app.db_session.add(pttt)
	for item in seats:
		ls = lichsudatghe(MaChuyen = route_id, MaNguoiDung = user_id, IDGhe = item, NgayDat = date, MaVe = vx.MaVe)
		app.db_session.add(ls)
	app.db_session.commit()
    # we can then use this for your particular example
	
	resp = {'error' : 'false', 'message' : 'Đặt vé thành công', 'id' : vx.MaVe}
	return resp


@client.route("/check_avai_seat", methods=['POST'])
def check_avai_seat():
    route_id  = request.json['route_id']
    date  = request.json['date']
    taken_list = app.db_session.query(lichsudatghe).filter_by(MaChuyen = route_id, NgayDat = date).all()
    # we can then use this for your particular example
    list = [serialize(seat) for seat in taken_list]
    data_json = dumps({'data' : list}, default = str)
    resp = data_json
    return resp



def generate_unique_filename(filename):
    timestamp = datetime.now().strftime('%Y%m%d%H%M%S')
    _, extension = os.path.splitext(filename)
    unique_filename = f"{timestamp}{extension}"
    return secure_filename(unique_filename)


def get_matching_route(bg_point):
    matching_route = app.db_session.query(lotrinh.MaChuyen).filter(lotrinh.TenDiem.ilike(bg_point)).distinct().all()
    return [item[0] for item in matching_route]

