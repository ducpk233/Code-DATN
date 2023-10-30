
from http import client
from json import dumps
from lib2to3.pgen2 import driver
from flask_qrcode import QRcode
from sqlalchemy import false
from app import mail, app, chuyenxe, datve, lichsudatghe, lotrinh, nguoidung, khachhang, phuongthucthanhtoan, taixe, xebus
from flask import Blueprint, redirect, render_template, session, url_for
from datetime import datetime
from flask import jsonify, request, flash
import database as db
from datetime import datetime
from sqlalchemy.orm import scoped_session, sessionmaker, Query
from flask_mail import Mail, Message
from routes.admin.helper import serialize
import secrets

apiv1 = Blueprint('api', __name__)


@apiv1.route('/')
def welcome():
	
	return render_template('start.html')

#đăng nhập
@apiv1.route('/login', methods=['POST', 'GET'])
def login():
    data = request.json
    if request.method == 'POST': 
        email = data.get("email")
        pw = data.get("password")
        if email and pw:
            exist = app.db_session.query(nguoidung).filter_by(TaiKhoan=email, MatKhau = pw, VaiTro = 0).first()
            if bool(exist):
                user = serialize(exist)
                resp = {'error' : False, 'message' : user}
                return jsonify(resp)
            else:
                return jsonify({'error' : True, 'message' : 'Email hoặc mật khẩu không chính xác'})
        else:
            return jsonify({'error' : True, 'message' : 'Email hoặc mật khẩu không được trống!'})
    else:
        return jsonify({'error' : True, 'message' : 'wrong method!'})

#quên mật khẩu
@apiv1.route('/forget_password', methods=['POST'])
def forget_password():
    data = request.json
    if request.method == 'POST': 
        email = data.get("email")
        if email:
            exist = app.db_session.query(nguoidung).filter_by(TaiKhoan=email, VaiTro = 0).first()
            if bool(exist):
                try:
                    new_pw =  secrets.token_hex(3)
                    exist.MatKhau = new_pw
                    body = "Đặt lại mật khẩu thành công. Mật khẩu mới của bạn là: " + new_pw
                    message = Message(subject="Đặt lại mật khẩu!", recipients=[exist.TaiKhoan], body=body)

                # Gửi email
                    mail.send(message)
                    app.db_session.commit()
                    resp = {'error' : False, 'message' : "Đặt lại mật khẩu thành công! Vui lòng kiểm tra hộp thư của bạn!"}
                    return jsonify(resp)
                except Exception as e:
                    print(str(e))
                    resp = {'error' : True, 'message' : "Lỗi gửi email!"}
                    return jsonify(resp)
            else:
                return jsonify({'error' : True, 'message' : 'Email bạn vừa nhập không tồn tại!'})
        else:
            return jsonify({'error' : True, 'message' : 'Email không được trống!'})
    else:
        return jsonify({'error' : True, 'message' : 'wrong method!'})


#đăng ký
@apiv1.route('/register',  methods=['POST'])
def register():
    
    if request.method == 'POST': 
        data = request.json
        email = data.get("email")
        pw = data.get("password")
        exist = bool(app.db_session.query(nguoidung).filter_by(TaiKhoan=email).first())
        if exist:
            resp = {'error' : True, 'message' : "Email đã được sử dụng!"}   
            return jsonify(resp)
        else:
            if email and pw:
                nd =  nguoidung(TaiKhoan = email, MatKhau = pw, TrangThai = 1, NgayTao = datetime.now(),VaiTro = 0 )
                app.db_session.add(nd)
                app.db_session.commit()
                kh =  khachhang(MaNguoiDung = nd.MaNguoiDung)
                app.db_session.add(kh)
                app.db_session.commit()
                resp = {'error' : False, 'message' : "Đăng ký thành công! Bạn sẽ được chuyển hướng sang trang đăng nhập!"}
                return jsonify(resp)
            else:
                resp = {'error' : True, 'message' : "Email và mật khẩu không được trống!"}
                return jsonify(resp)
	


@apiv1.route('/home')
def home():
	bg_point = []
	get_route = app.db_session.query(chuyenxe).filter_by(TrangThai = 1).all()
	bg_point = list(set([item.DiemBatDau for item in get_route]))
	print(bg_point)
	return render_template('home.html', bg_point = bg_point)
#trang đặt vé 	
@apiv1.route('/my_ticket')
def my_ticket():
	id = session['id']
	kh = app.db_session.query(khachhang).filter_by(MaNguoiDung=id).first()	
	ticket_list = app.db_session.query(datve).filter_by(MaKhachHang=kh.MaKhachHang).all()
	cx = app.db_session.query(chuyenxe).all()
	return render_template('my-ticket.html', tickets = ticket_list, cx = cx)
#chi tiết vé
#nhận vào id, trả về thông tin vé
@apiv1.route('/ticket_detail/:id')
def ticket_detail():
	return render_template('my-ticket.html')


#trang thông tin tài khoản
@apiv1.route('/account', methods=['POST', 'GET'])
def account():
	id = session['id']
	user= app.db_session.query(nguoidung).filter_by(MaNguoiDung=id).first()	
	user_info = app.db_session.query(khachhang).filter_by(MaNguoiDung=id).first()	
	if request.method == 'POST': 
		name = request.form["fullname"]
		address = request.form["add"]
		nation_id = request.form["natid"]
		user_info.HoVaTenKhachHang = name
		user_info.DiaChi = address
		user_info.CMND = nation_id
		app.db_session.commit()
		flash('Cập nhật thành công!')
	return render_template('profile.html', user = user, user_info = user_info)
	
@apiv1.route('/contact')
def contact():
	return render_template('contact.html')
	
@apiv1.route('/notification')
def notification():
	return render_template('notification.html')	

@apiv1.route('/select_seat', methods=['GET'])
def select_seat():
	bg_point = request.args.get('bg_point')
	arr_point = request.args.get('arr_point')
	date = request.args.get('date')
	route = app.db_session.query(chuyenxe).filter_by(DiemBatDau = bg_point, DiemKetThuc = arr_point).first()
	busid  = route.MaXeBus
	driverid  = route.MaTaiXe
	bus = app.db_session.query(xebus).filter_by(MaXeBus = busid).first()
	driver = app.db_session.query(taixe).filter_by(MaTaiXe = driverid).first()
	path = app.db_session.query(lotrinh).filter_by(MaChuyen = route.MaChuyen).all()
	return render_template('select-seat.html', route = route, bus = bus, driver = driver, path = path)	


#apiv1
@apiv1.route("/get_arr_point_apiv1", methods=['POST'])
def get_arr_point_apiv1():
    bgp  = request.json['bg']
    driver_list = app.db_session.query(chuyenxe).filter_by(DiemBatDau = bgp, TrangThai = 1).all()
    # we can then use this for your particular example
    list = [serialize(tx) for tx in driver_list]
    data_json = dumps({'data' : list}, default = str)
    resp = data_json
    return resp

@apiv1.route("/book_ticket_apiv1", methods=['POST'])
def book_ticket_apiv1():
	seats  = request.json['seat']
	route_id  = request.json['route_id']
	user_id  = session["id"]
	get_customer = app.db_session.query(khachhang).filter_by(MaNguoiDung = user_id).first()
	total  = request.json['total']
	date = request.json['date']
	vx = datve(NgayDat = datetime.now(), MaChuyen = route_id, MaKhachHang = get_customer.MaKhachHang, TrangThai = 1, NgayDi = date)
	app.db_session.add(vx)
	app.db_session.commit()
	ticket_id = vx.MaVe
	pttt = phuongthucthanhtoan(MaKhachHang = get_customer.MaKhachHang, MaVe = ticket_id, PhuongThucThanhToan = 0, TrangThai = 0, SoTien = total)
	app.db_session.add(pttt)
	for item in seats:
		ls = lichsudatghe(MaChuyen = route_id, MaNguoiDung = user_id, IDGhe = item, NgayDat = date)
		app.db_session.add(ls)
	app.db_session.commit()
    # we can then use this for your particular example
	
	resp = {'error' : 'false', 'message' : 'Đặt vé thành công'}
	return resp


@apiv1.route("/check_avai_seat", methods=['POST'])
def check_avai_seat():
    route_id  = request.json['route_id']
    date  = request.json['date']
    taken_list = app.db_session.query(lichsudatghe).filter_by(MaChuyen = route_id, NgayDat = date).all()
    # we can then use this for your particular example
    list = [serialize(seat) for seat in taken_list]
    data_json = dumps({'data' : list}, default = str)
    resp = data_json
    return resp