
from http import client
from json import dumps
from lib2to3.pgen2 import driver
from flask_qrcode import QRcode
from sqlalchemy import false
from app import app, chuyenxe, datve, lichsudatghe, lotrinh, nguoidung, khachhang, phuongthucthanhtoan, taixe, xebus
from flask import Blueprint, redirect, render_template, session, url_for
from datetime import datetime
from flask import jsonify, request, flash
import database as db
from datetime import datetime
from sqlalchemy.orm import scoped_session, sessionmaker, Query

from routes.admin import serialize


client = Blueprint('client', __name__)


@client .route('/')
def welcome():
	
	return render_template('start.html')

@client .route('/logout')
def logout():
	session.clear()
	return redirect(url_for('client.welcome'))
#đăng nhập
@client .route('/login', methods=['POST', 'GET'])
def login():
	if request.method == 'POST': 
		phone = request.form["phone"]
		pw = request.form["password"]
		if phone and pw:
			exist = app.db_session.query(nguoidung).filter_by(SoDienThoai=phone, MatKhau = pw, VaiTro = 0).first()
			if bool(exist):
				session.clear()
				session["id"] = exist.MaNguoiDung
				return redirect(url_for('client.home'))
			else:
				flash("Số điện thoại hoặc mật khẩu không chính xác!")
		else:
			flash('Số điện thoại hoặc mật khẩu không được trống!')
	return render_template('signin.html')

#đăng ký
@client.route('/register',  methods=['POST', 'GET'])
def register():
	if request.method == 'POST': 
		phone = request.form["phone"]
		pw = request.form["password"]
		rtpw = request.form["rtpassword"]
		exist = bool(app.db_session.query(nguoidung).filter_by(SoDienThoai=phone).first())
		if exist:
			flash('Số điện thoại đã được đăng ký!')
		else:
			if phone and pw and rtpw:
				if pw != rtpw:
					flash('Nhập lại mật khẩu không chính xác')
				else:
					nd =  nguoidung(TaiKhoan = phone, MatKhau = pw, SoDienThoai = phone, TrangThai = 1, NgayTao = datetime.now(),VaiTro = 0 )
					app.db_session.add(nd)
					app.db_session.commit()
					kh =  khachhang(MaNguoiDung = nd.MaNguoiDung, SoDienThoai = phone )
					app.db_session.add(kh)
					app.db_session.commit()
					return redirect(url_for('client.login'))
			else:
				flash("Vui lòng nhập đủ số điện thoại, mật khẩu và xác nhận mật khẩu!")
	return render_template('signup.html')


@client.route('/home')
def home():
	bg_point = []
	get_route = app.db_session.query(chuyenxe).filter_by(TrangThai = 1).all()
	bg_point = list(set([item.DiemBatDau for item in get_route]))
	print(bg_point)
	return render_template('home.html', bg_point = bg_point)
#trang đặt vé 	
@client.route('/my_ticket')
def my_ticket():
	id = session['id']
	kh = app.db_session.query(khachhang).filter_by(MaNguoiDung=id).first()	
	ticket_list = app.db_session.query(datve).filter_by(MaKhachHang=kh.MaKhachHang).all()
	cx = app.db_session.query(chuyenxe).all()
	return render_template('my-ticket.html', tickets = ticket_list, cx = cx)
#chi tiết vé
#nhận vào id, trả về thông tin vé
@client.route('/ticket_detail/:id')
def ticket_detail():
	return render_template('my-ticket.html')


#trang thông tin tài khoản
@client.route('/account', methods=['POST', 'GET'])
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
	
@client.route('/contact')
def contact():
	return render_template('contact.html')
	
@client.route('/notification')
def notification():
	return render_template('notification.html')	

@client.route('/select_seat', methods=['GET'])
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


#api
@client.route("/get_arr_point_api", methods=['POST'])
def get_arr_point_api():
    bgp  = request.json['bg']
    driver_list = app.db_session.query(chuyenxe).filter_by(DiemBatDau = bgp, TrangThai = 1).all()
    # we can then use this for your particular example
    list = [serialize(tx) for tx in driver_list]
    data_json = dumps({'data' : list}, default = str)
    resp = data_json
    return resp

@client.route("/book_ticket_api", methods=['POST'])
def book_ticket_api():
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