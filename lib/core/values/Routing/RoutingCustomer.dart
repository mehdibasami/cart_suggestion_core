import 'RoutingBase.dart';

class RoutingCustomer extends RoutingBase {
  static const BaseName = "Customer";

  static const GET_GetCustomer =
      "${RoutingBase.ApiUrlV2}/$BaseName/GetCustomersV2";
  static const POST_CheckCustomerCredit =
      "${RoutingBase.ApiUrl}/$BaseName/CheckIfCustomerHasCredit";
}
