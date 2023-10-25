from app import app, nguoidung, khachhang
from flask import session
import database as db
from datetime import datetime
from routes import admin, client

#return user
@app.context_processor
def inject_user():
	if 'id' in session:
		user = app.db_session.query(nguoidung).filter_by(MaNguoiDung = session["id"]).first()
		return dict(user = user)
	else: 
		return {'empty' : ''}


		
if __name__ == "__main__":
	app.register_blueprint(client.client, url_prefix='/')
	app.register_blueprint(admin.admin, url_prefix='/admin')
	app.run(host='0.0.0.0', debug=True, ssl_context=('cert.pem', 'key.pem'))