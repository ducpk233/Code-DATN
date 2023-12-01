from json import dumps
from flask import jsonify, render_template, request, session
from routes.admin.helper import login_required, roles_required, serialize
from app import app, chuyenxe, datve, khachhang, lichsudatghe, nguoidung, phuongthucthanhtoan, taixe
from datetime import datetime
from routes.admin import  *

#quản lý thu ngân
#api
@padmin.route('/add_cashier_api', methods=['POST'])
def add_cashier_api():
    _json = request.json
    _fname = _json['fname']
    _phone = _json['phone']
    _pw = _json['pw']
    _dmail = _json['dmail']		
    exist = bool(app.db_session.query(nguoidung).filter_by(TaiKhoan=_dmail).first())
    if exist:
        resp = jsonify({'error' : True, 'message' : 'Email đã tồn tại!'})
        return resp
    else:
        nd =  nguoidung(TaiKhoan = _dmail, MatKhau = _pw, SoDienThoai = _phone, TrangThai = 1, NgayTao = datetime.now(), VaiTro = 2 )
        app.db_session.add(nd)
        app.db_session.commit()
        resp = jsonify({'error' : False, 'message' : 'Thêm thu ngân thành công!'})
        return resp
from datetime import date, datetime

def json_serial(obj):
    """JSON serializer for objects not serializable by default json code"""

    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    
@padmin.route("/cashier_list_api")
def cashier_list_api():
    list = []
    cashier_list = app.db_session.query(nguoidung).filter(nguoidung.VaiTro == 2).all()
    list = [serialize(tx) for tx in cashier_list]
    data_json = dumps({'data' : list},  default=json_serial)
    resp = data_json
    return resp


@padmin.route("/del_cashier_api", methods = ['POST'])
def del_cashier_api():
    _json = request.json
    id = _json['id']
    usr = app.db_session.query(nguoidung).filter_by(MaNguoiDung = id).first()
    if usr:
        app.db_session.delete(usr)
        app.db_session.commit()
        return jsonify({'error': False, 'message': 'Đã xóa thành công!'})
    else:
        return jsonify({'error': True, 'message': 'Thu ngân không tồn tại. Vui lòng tải lại trang!'})
    
@padmin.route("/get_cashier_api/<int:id>", methods = ['GET'])
def get_cashier_api(id): 
    us = app.db_session.query(nguoidung).filter_by(MaNguoiDung = id).first()
    if  us:
        return jsonify({'error': False, 'data': {'cashier_info' : serialize(us)}})
    else:
        return jsonify({'error': True, 'message': 'Thu ngân không tồn tại. Vui lòng tải lại trang!'})
    
@padmin.route('/update_cashier_api/<int:id>', methods=['POST'])
def update_cashier_api(id):
 
    _json = request.json
    
    _phone = _json['phone']
    _pw = _json['pw']
    _dmail = _json['dmail']		
    _status = int(_json['status'])	

    cashier = app.db_session.query(nguoidung).filter_by(MaNguoiDung = id).first()
    cashier.SoDienThoai = _phone
    cashier.MatKhau = _pw
    cashier.TrangThai = _status
    if (_dmail.strip() != cashier.TaiKhoan):
        exist = bool(app.db_session.query(nguoidung).filter_by(TaiKhoan=_dmail).first())
        if exist:
            resp = jsonify({'error' : True, 'message' : 'Email đã tồn tại!'})
            return resp
        else:
            cashier.TaiKhoan = _dmail
    app.db_session.commit()
    return jsonify({'error' : False, 'message' : 'Cập nhật thu ngân thành công!'})
    