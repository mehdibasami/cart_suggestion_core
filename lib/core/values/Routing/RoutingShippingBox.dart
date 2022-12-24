import 'RoutingBase.dart';

class RoutingShipping extends RoutingBase {
  static const BaseName = "ShippingBox";

  static const GET_GetAllShippers = "${RoutingBase.ApiUrl}/$BaseName/GetAllShippers";
  static const GET_GetAllCountries = "${RoutingBase.ApiUrl}/$BaseName/GetAllCountries";

}