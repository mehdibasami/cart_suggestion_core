import 'package:cart_suggestion_core/cart_suggestion_core.dart';

class CartSuggestionVehiclePagingModel
    extends PagingModel<CartSuggestionVehicleEntity> {
  List<CartSuggestionVehicleEntity> values = [];
  CartSuggestionVehiclePagingModel({
    required super.size,
    required super.page,
    required super.totalCount,
    required super.totalPage,
  });

  CartSuggestionVehiclePagingModel.fromJson(Map<String, dynamic> jsn)
      : super.fromJson(jsn) {
    values = buildList(jsn['values']);
  }
  List<CartSuggestionVehicleEntity> buildList(jsonList) {
    if (jsonList != null) {
      return (jsonList as List)
          .map((e) => CartSuggestionVehicleModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
