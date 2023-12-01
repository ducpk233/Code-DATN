LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'Asia/Saigon'

USE_I18N = True

USE_L10N = True

USE_TZ = True

# VNPAY CONFIG
VNPAY_RETURN_URL = 'https://192.168.1.18:5000/payment_return'  # get from config
VNPAY_RETURN_INVOICE = 'https://192.168.1.5:5000/payment_return_invoice'
VNPAY_PAYMENT_URL = 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html'  # get from config
VNPAY_API_URL = 'https://sandbox.vnpayment.vn/merchant_webapi/api/transaction'
VNPAY_TMN_CODE = 'HGK32TY1'  # Website ID in VNPAY System, get from config
VNPAY_HASH_SECRET_KEY = 'ZNWFRSHJHLFRQZGWUYDVBOSIECGTYNIA'  # Secret key for create checksum,get from config
