const String baseUrlAuth = "http://103.196.152.113:3000/user";
const String baseUrlHome = "http://103.196.152.113:3000/drug";
const String baseUrlCart = "http://103.196.152.113:3000/cart";
const String baseUrlOrder = "http://103.196.152.113:3000/order";

const String registerEndpoint = "$baseUrlAuth/register";
const String loginEndpoint = "$baseUrlAuth/login";

const String drugListEndpoint = "$baseUrlHome/list";
const String drugLengthEndpoint = "$baseUrlHome/datalength";

const String addItemToCartEndpoint = "$baseUrlCart/add";
const String getCartItemsEndpoint = "$baseUrlCart/list";
const String updateCartItemQuantityEndpoint = "$baseUrlCart/updatequantity";
const String deleteCartItemEndpoint = "$baseUrlCart/delete";
const String checkoutOrderEndpoint =
    "http://103.196.152.113:3000/order/placedorder";

const String getOrderDetailsEndpoint = "$baseUrlOrder/detail";
const String payOrderEndpoint = "$baseUrlOrder/paid";
const String getUnpaidOrdersEndpoint = "$baseUrlOrder/unpaidlist";
const String getPaidOrdersEndpoint = "$baseUrlOrder/paidlist";
const String cancelOrderEndpoint = "$baseUrlOrder/cancel";
const String getCancelledOrdersEndpoint = "$baseUrlOrder/cancellist";
