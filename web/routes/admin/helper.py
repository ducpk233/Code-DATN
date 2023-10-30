from functools import wraps
from flask import redirect, session, url_for
from sqlalchemy.orm import class_mapper

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get('admin_id') is None and session.get('driver_id') is None:
            return redirect(url_for('admin.login_page'))
        return f(*args, **kwargs)
    return decorated_function

def serialize(model):
  """Transforms a model into a dictionary which can be dumped to JSON."""
  # first we get the names of all the columns on your model
  columns = [c.key for c in class_mapper(model.__class__).columns]
  # then we return their values in a dict
  return dict((c, getattr(model, c)) for c in columns)