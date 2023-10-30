from datetime import datetime
from functools import wraps
from lib2to3.pgen2 import driver
from flask import Blueprint, jsonify, redirect, render_template, request, session, url_for
from sqlalchemy import false, true
from app import app, chuyenxe, ghexebus, lichsudatghe, nguoidung, khachhang, phuongthucthanhtoan, taixe, xebus, ghexebus, datve, lotrinh
from json import dumps
from sqlalchemy.orm import class_mapper
import json
from flask import Blueprint

from routes.admin import padmin
from routes.admin.helper import login_required


@padmin.route("/")
@login_required
def admin_home():
    return render_template('admin/index.html')



#api
@padmin.route("/login_page")
def login_page():
    return render_template('admin/login.html')
@padmin.route("/logout")
def logout():
    if 'admin_id' in session:
        session.pop('admin_id')
    else:
        session.pop('driver_id')
    return redirect('/admin/login_page')
@padmin.route("/login", methods = ['POST'])
def login():
    _json = request.json
    email = _json['email']
    pw = _json['pw']
    if email and pw:
        exist = app.db_session.query(nguoidung).filter_by(TaiKhoan = email, MatKhau = pw).filter((nguoidung.VaiTro ==3) | (nguoidung.VaiTro == 1)).first()
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
            resp = jsonify({'error' : 'true', 'message' : 'Email hoặc mật khẩu không chính xác!'})
            return resp
    else:
        resp = jsonify({'error' : 'true', 'message' : 'Email hoặc mật khẩu không được trống!'})
        return resp

@padmin.route("/test_qr")

def test_qr():
    
    return render_template('admin/test_qr.html')