from functools import wraps
from flask import abort, redirect, session, url_for
from sqlalchemy.orm import class_mapper

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get('admin_id') is None and session.get('driver_id') is None and session.get('cashier_id') is None:
            return redirect(url_for('admin.login_page'))
        return f(*args, **kwargs)
    return decorated_function
#giới hạn role, đầu vào, 3 admin, 2 thu ngân, 1 tài xế
def roles_required(*required_roles):
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            user_roles = str(session.get('role', []))
            if not any(role in user_roles for role in required_roles):
                # Return 403 Forbidden if none of the required roles is valid
                abort(403)

            return f(*args, **kwargs)
        return decorated_function
    return decorator
def serialize(model):
  """Transforms a model into a dictionary which can be dumped to JSON."""
  # first we get the names of all the columns on your model
  columns = [c.key for c in class_mapper(model.__class__).columns]
  # then we return their values in a dict
  return dict((c, getattr(model, c)) for c in columns)