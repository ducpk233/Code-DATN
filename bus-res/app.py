from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker, Query
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, backref
from flask_session import Session
from flask_qrcode import QRcode
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
