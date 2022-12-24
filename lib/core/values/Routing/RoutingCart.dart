import 'RoutingBase.dart';

class RoutingCart {
  static const BaseName = "Cart";

  // static const GET_Get = "${RoutingBase.ApiUrl}/$BaseName/GetSimple";
  // static const GET_GetCustomerOrderDetails =
  //     "${RoutingBase.ApiUrl}/$BaseName/GetCustomerOrderDetails";
  static const GET_GenerateOrderWithAddress =
      "${RoutingBase.ApiUrl}/$BaseName/GenerateOrderWithAddress";

  static const Get_MyCart = "${RoutingBase.ApiUrlV2}/$BaseName/MyCart";

  // static const POST_PayOrder = "${RoutingBase.ApiUrl}/$BaseName/PayOrder";
  // static const POST_AddProduct =
  //     "${RoutingBase.ApiUrl}/$BaseName/AddProductSimple";
  static const POST_Add2CartV2 = "${RoutingBase.ApiUrlV2}/$BaseName/Add2CartV2";
  static const POST_Update2CartV2 =
      "${RoutingBase.ApiUrlV2}/$BaseName/Update2CartV2";
  static const DELETE_Delete2CartV2 =
      "${RoutingBase.ApiUrlV2}/$BaseName/Delete2CartV2";
  static const DELETE_DeleteCartV2 =
      "${RoutingBase.ApiUrlV2}/$BaseName/DeleteCartV2";
  // static const POST_UpdateAddress =
  //     "${RoutingBase.ApiUrl}/$BaseName/UpdateAddress";

  // static const POST_SendCart = "${RoutingBase.ApiUrl}/$BaseName/SentCartToUser";

  // static const DELETE_DeleteCart = "${RoutingBase.ApiUrl}/$BaseName/DeleteCart";
  // static const DELETE_DeleteProduct =
  //     "${RoutingBase.ApiUrl}/$BaseName/DeleteProductSimple";
  static const DELETE_DeleteCartById =
      "${RoutingBase.ApiUrl}/$BaseName/DeleteCart";

  // static const PUT_UpdateProduct =
  //     "${RoutingBase.ApiUrl}/$BaseName/UpdateProductSimple";
  // static const GET_Payment =
  //     "${RoutingBase.ApiUrl}/$BaseName/GenerateOrderWithAddress";
  static const GET_PaymentZarinPal =
      "${RoutingBase.ApiUrl}/$BaseName/GenerateOrderWithAddressZarrin";
  static const POST_PaymentZarinPal =
      "${RoutingBase.ApiUrl}/$BaseName/GenerateOrderWithAddressZarrin";
  static const POST_Cart2Order = "${RoutingBase.ApiUrlV2}/$BaseName/Card2Order";
  // static const GET_GenerateManualOrder =
  //     "${RoutingBase.ApiUrlV2}/$BaseName/GenerateManualOrder";

  // static const GET_GenerateManualOrderV2 =
  //     "${RoutingBase.ApiUrlV2}/$BaseName/GenerateManualOrderV2";

  static const POST_Cart2OrderModel =
      "${RoutingBase.ApiUrlV2}/$BaseName/Card2OrderModel";
}
