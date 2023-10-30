from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker, Query
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, backref
from flask_session import Session
from flask_qrcode import QRcode
from flask_mail import Mail, Message

UPLOAD_FOLDER = 'static/uploads'
app = Flask(__name__)

app.jinja_env.auto_reload = True
app.config['TEMPLATES_AUTO_RELOAD'] = True
app.secret_key = "super secret key"

app.config['SQLALCHEMY_DATABASE_URI_1'] = 'mysql://root@localhost:3306/quanlydatvexe'


engine = create_engine(app.config['SQLALCHEMY_DATABASE_URI_1'])

app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

Base = declarative_base()
Base.metadata.reflect(engine)

class nguoidung(Base):
    __table__ = Base.metadata.tables['nguoidung']
class khachhang(Base):
    __table__ = Base.metadata.tables['khachhang']  
class xebus(Base):
    __table__ = Base.metadata.tables['xebus']  
class ghexebus(Base):
    __table__ = Base.metadata.tables['ghexebus']  
class datve(Base):
    __table__ = Base.metadata.tables['datve']  
class lichlaixe(Base):
    __table__ = Base.metadata.tables['lichlaixe']  
class phuongthucthanhtoan(Base):
    __table__ = Base.metadata.tables['phuongthucthanhtoan']  
class chuyenxe(Base):
    __table__ = Base.metadata.tables['chuyenxe']  
class taixe(Base):
    __table__ = Base.metadata.tables['taixe']  
class lotrinh(Base):
    __table__ = Base.metadata.tables['lotrinh']  
class lichsudatghe(Base):
    __table__ = Base.metadata.tables['lichsudatghe']  
QRcode(app)
app.db_session = scoped_session(sessionmaker(bind=engine))

#mail config

# Cấu hình Flask-Mail để sử dụng Gmail
app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USE_SSL'] = False
app.config['MAIL_USERNAME'] = 'ntrungtruc70@gmail.com'  # Địa chỉ Gmail của bạn
app.config['MAIL_PASSWORD'] = 'nocgxqbgtnodvtqj'  # Mật khẩu ứng dụng Gmail

# Tính năng bảo mật cho ứng dụng không an toàn
app.config['MAIL_DEFAULT_SENDER'] = 'ntrungtruc70@gmail.com'  # Địa chỉ Gmail của bạn
app.config['MAIL_SUPPRESS_SEND'] = False
app.config['TESTING'] = False

mail = Mail(app)