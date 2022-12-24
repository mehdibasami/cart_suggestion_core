import 'RoutingBase.dart';

class RoutingOrder extends RoutingBase {
  static const BaseName = "Order";

  static const GET_GetOrdersInfo =
      "${RoutingBase.ApiUrlV2}/$BaseName/GetOrdersInfo";
  // static const GET_GetWithDetail =
  //     "${RoutingBase.ApiUrl}/$BaseName/GetWithDetail";
  static const Post_ZarrinPayOrder =
      "${RoutingBase.ApiUrl}/$BaseName/ZarrinPayOrder";
  static const GET_GetConfirmedOrders =
      "${RoutingBase.ApiUrlV2}/$BaseName/ConfirmedOrdersV2";
  static const GET_GetAllConfirmedOrders =
      "${RoutingBase.ApiUrlV2}/$BaseName/AllConfirmedOrdersV2";
  static const GET_GetOrderInfo =
      "${RoutingBase.ApiUrlV2}/$BaseName/GetOrderInfo";
  static const GET_GetSendingOrders =
      "${RoutingBase.ApiUrlV2}/$BaseName/SendingOrdersV2";
  static const GET_GetPendingOrders =
      "${RoutingBase.ApiUrlV2}/$BaseName/PendingOrdersV2";
  static const GET_GetAllMyCommissionOrders =
      "${RoutingBase.ApiUrl}/$BaseName/GetAllMyCommissionOrders";
  static const GET_FeedOrdersFilter =
      "${RoutingBase.ApiUrl}/$BaseName/FeedOrdersFilter";
  static const POST_OrdersFilter =
      "${RoutingBase.ApiUrl}/$BaseName/OrdersFilter";
  static const GET_Verify = "${RoutingBase.ApiUrl}/$BaseName/GetWithAuthoriy";
  static const GET_GetOrderPath =
      "${RoutingBase.ApiUrlV2}/$BaseName/GetOrderPath";
  static const POST_GetUserOrdersBook =
      "${RoutingBase.ApiUrlV2}/$BaseName/GetUserOrdersBook";
  static const POST_GetUserOrdersBookOptions =
      "${RoutingBase.ApiUrlV2}/$BaseName/GetUserOrdersBookOptions";
  static const POST_IncreaseProduct =
      "${RoutingBase.ApiUrlV2}/$BaseName/IncreaseProductV2";
  static const POST_DecreaseProduct =
      "${RoutingBase.ApiUrlV2}/$BaseName/DecreaseProductV2";
  static const POST_AddProduct =
      "${RoutingBase.ApiUrlV2}/$BaseName/AddProductV2";
  static const Delete_DeleteProduct =
      "${RoutingBase.ApiUrlV2}/$BaseName/DeleteProduct";
}
