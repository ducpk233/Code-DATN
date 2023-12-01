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


padmin = Blueprint('admin', __name__)

from .bus import bus_api
from .bus_route import route_api
from routes.admin.admin_api import *
from .customer import customer_api
from .driver import driver_api
from .cashier import cashier_api
from .invoice import invoice_api
