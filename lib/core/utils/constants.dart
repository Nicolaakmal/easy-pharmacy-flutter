const String _host = 'localhost';
const int _port = 3000;

/* ---------- base paths ---------- */
const String _baseAuth = 'http://$_host:$_port/user';
const String _baseDrug = 'http://$_host:$_port/drug';
const String _baseCart = 'http://$_host:$_port/cart';
const String _baseOrder = 'http://$_host:$_port/order';

/* ---------- auth ---------- */
const String registerEndpoint = '$_baseAuth/register';
const String loginEndpoint = '$_baseAuth/login';

/* ---------- drug ---------- */
const String drugListEndpoint = '$_baseDrug/list';
const String drugLengthEndpoint = '$_baseDrug/datalength';

/* ---------- cart ---------- */
const String addItemToCartEndpoint = '$_baseCart/add';
const String getCartItemsEndpoint = '$_baseCart/list';
const String updateCartItemQuantityEndpoint = '$_baseCart/updatequantity';
const String deleteCartItemEndpoint = '$_baseCart/delete';

/* ---------- order ---------- */
const String checkoutOrderEndpoint = '$_baseOrder/placedorder';
const String getOrderDetailsEndpoint = '$_baseOrder/detail';
const String payOrderEndpoint = '$_baseOrder/paid';
const String getUnpaidOrdersEndpoint = '$_baseOrder/unpaidlist';
const String getPaidOrdersEndpoint = '$_baseOrder/paidlist';
const String cancelOrderEndpoint = '$_baseOrder/cancel';
const String getCancelledOrdersEndpoint = '$_baseOrder/cancellist';
