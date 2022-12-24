

import 'package:cart_suggestion_core/cart_suggestion_core.dart';

class CartSuggestionBrandPagingModel
    extends PagingModel<CartSuggestionBrandEntity> {
  List<CartSuggestionBrandEntity> values = [];
  CartSuggestionBrandPagingModel({
    required super.size,
    required super.page,
    required super.totalCount,
    required super.totalPage,
  });

  CartSuggestionBrandPagingModel.fromJson(Map<String, dynamic> jsn)
      : super.fromJson(jsn) {
    values = buildList(jsn['values']);
  }
  List<CartSuggestionBrandEntity> buildList(jsonList) {
    if (jsonList != null) {
      return (jsonList as List)
          .map((e) => CartSuggestionBrandModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
