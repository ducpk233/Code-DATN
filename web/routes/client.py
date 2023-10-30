
from functools import wraps
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

from routes.admin.helper import serialize

from werkzeug.utils import secure_filename
import os

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
	print(bg_point)
	return render_template('mindex.html', bg_point = bg_point)
	
	
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
	return render_template('mindex.html', bg_point = bg_point)
	
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



def generate_unique_filename(filename):
    timestamp = datetime.now().strftime('%Y%m%d%H%M%S')
    _, extension = os.path.splitext(filename)
    unique_filename = f"{timestamp}{extension}"
    return secure_filename(unique_filename)