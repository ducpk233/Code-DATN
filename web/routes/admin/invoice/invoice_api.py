
from json import dumps
from flask import jsonify, render_template, request, session
from routes.admin.helper import login_required, roles_required, serialize
from app import app, chuyenxe, datve, hoadon, khachhang, lichsudatghe, lichsuvi, nguoidung, phuongthucthanhtoan, taixe, vinguoidung
from datetime import datetime
from routes.admin import  *
from sqlalchemy.orm import aliased


#-quản lý hóa đơn
#tạo mới
@padmin.route("/invoice_export/<int:id>")
@login_required
@roles_required("3", "2")
def invoice_export(id):
    now = datetime.now()
    customer = app.db_session.query(nguoidung, khachhang).join(khachhang).filter(nguoidung.MaNguoiDung == id).first()
    wallet = app.db_session.query(vinguoidung).filter(vinguoidung.MaNguoiDung == id).first()
    print(wallet.MaVi)
    wallet_history = app.db_session.query(lichsuvi).filter(lichsuvi.MaVi == wallet.MaVi).all()
    return render_template('admin/invoice_export.html', customer = customer, wallet = wallet, wallet_history = wallet_history, now = now.date())  
#chi tiết
@padmin.route("/invoice_detail/<int:id>")
@login_required
@roles_required("3", "2")
def invoice_detail(id):
    now = datetime.now()
    invoice = app.db_session.query(hoadon).filter(hoadon.MaHoaDon == id).first()
    if invoice:
        invoice_items = json.loads(invoice.ChiTietDichVu)
        customer = app.db_session.query(nguoidung, khachhang).join(khachhang).filter(nguoidung.MaNguoiDung == invoice.MaNguoiDung).first()
        wallet = app.db_session.query(vinguoidung).filter(vinguoidung.MaNguoiDung == invoice.MaNguoiDung).first()
        wallet_history = app.db_session.query(lichsuvi).filter(lichsuvi.MaVi == wallet.MaVi).all()
        
        return render_template('admin/invoice_detail.html', customer = customer, wallet = wallet, 
                            wallet_history = wallet_history, now = now.date(), invoice = invoice, invoice_items = invoice_items
                            )  
    else:
        return f"Hóa đơn có mã {id} không tồn tại!"

#xem trc
@padmin.route("/invoice_preview/<int:id>")
@login_required
@roles_required("3", "2")
def invoice_preview(id):
    now = datetime.now()
    invoice = app.db_session.query(hoadon).filter(hoadon.MaHoaDon == id).first()
    if invoice:
        invoice_items = json.loads(invoice.ChiTietDichVu)
        customer = app.db_session.query(nguoidung, khachhang).join(khachhang).filter(nguoidung.MaNguoiDung == invoice.MaNguoiDung).first()
        wallet = app.db_session.query(vinguoidung).filter(vinguoidung.MaNguoiDung == invoice.MaNguoiDung).first()
        wallet_history = app.db_session.query(lichsuvi).filter(lichsuvi.MaVi == wallet.MaVi).all()
        
        return render_template('admin/invoice_preview.html', customer = customer, wallet = wallet, 
                            wallet_history = wallet_history, now = now.date(), invoice = invoice, invoice_items = invoice_items
                            )  
    else:
        return f"Hóa đơn có mã {id} không tồn tại!" 
from sqlalchemy.orm import joinedload
#danh sách
@padmin.route("/invoice_list")
@login_required
@roles_required("3", "2")
def invoice_list():
    now = datetime.now()
    HoaDonAlias = aliased(hoadon)
    NguoiDungAlias = aliased(nguoidung)
    KhachHangAlias = aliased(khachhang)
    result = (
		app.db_session.query(NguoiDungAlias, HoaDonAlias, KhachHangAlias)
		.join(NguoiDungAlias, HoaDonAlias.MaNguoiDung == NguoiDungAlias.MaNguoiDung)
		.join(KhachHangAlias, NguoiDungAlias.MaNguoiDung == KhachHangAlias.MaNguoiDung)
		.all()
	)
	
    print(result)
    
    return render_template('admin/invoice_list.html', invoice_list = result, now = now.date()) 

#api
#api lưu hóa đơn
@padmin.route('/save_customer_invoice_api', methods=['POST'])
def save_customer_invoice_api():
    data = request.get_json()
    note = data.get('note')
    payment_method = data.get('paymentMethod')
    user_id = data.get('userId')
    items = data.get('items')
    total = data.get('total')
    
    invoice = hoadon(MaNguoiDung = user_id, ChiTietDichVu = str(json.dumps(items)), TrangThai = 0, SoTien = int(total),
                    PhuongThucThanhToan = int(payment_method), NgayLap = datetime.now(), LuuY = note )

    app.db_session.add(invoice)
    app.db_session.commit()
    return jsonify({'error' : False, 'message' : 'Lưu hóa đơn thành công!', 'id' : invoice.MaHoaDon})
   
#api cập nhật hóa đơn
@padmin.route('/update_customer_invoice_api/<int:id>', methods=['POST'])
def update_customer_invoice_api(id):
    data = request.get_json()
    note = data.get('note')
    payment_method = data.get('paymentMethod')
    payment_status = data.get('paymentStatus')
    items = data.get('items')
    total = data.get('total')
    
    invoice =  app.db_session.query(hoadon).filter(hoadon.MaHoaDon == id).first()
    if invoice:
        invoice.ChiTietDichVu = str(json.dumps(items))
        if int(payment_status) != invoice.TrangThai:
            if int(payment_status) == 1:
                invoice.NgayThanhToan = datetime.now()
            if int(payment_status) == 0:
                invoice.NgayThanhToan = None
            invoice.TrangThai = int(payment_status)
        invoice.PhuongThucThanhToan = int(payment_method)
        invoice.LuuY = note
        invoice.SoTien = int(total)
        
        app.db_session.commit()
        return jsonify({'error' : False, 'message' : 'Lưu hóa đơn thành công!', 'id' : invoice.MaHoaDon})
    else:
        return jsonify({'error' : True, 'message' : 'Không tìm thấy hóa đơn. Vui lòng truy cập danh sách hóa đơn và tải lại trang!', 'id' : invoice.MaHoaDon})
        