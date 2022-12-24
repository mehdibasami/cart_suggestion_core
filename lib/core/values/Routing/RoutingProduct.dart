import 'package:cart_suggestion_core/core/values/Routing/RoutingBase.dart';

class RoutingProduct extends RoutingBase {
  static const BaseName = 'Product';
  static const Get_CartSuggestionBrand =
      '${RoutingBase.ApiUrl}/$BaseName/SearchBrand';
  static const Get_CartSuggestionVehicle =
      '${RoutingBase.ApiUrl}/$BaseName/SearchVehicle';
}
