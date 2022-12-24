import 'RoutingBase.dart';

class RoutingProductInfo extends RoutingBase{
  static const BaseName = "ProductInfo";

  static const GET_TotalScore = "${RoutingBase.ApiUrl}/$BaseName/GetTotalScore";
  static const POST_EditProductLimitations = "${RoutingBase.ApiUrl}/$BaseName/EditProductLimitations";
}