import 'package:cart_suggestion_core/cart_suggestion_core.dart';

class CartsuggestionPagingModel extends PagingModel<CartSuggestionItemEntity> {
  List<CartSuggestionItemEntity> values = [];
  CartsuggestionPagingModel({
    required super.size,
    required super.page,
    required super.totalCount,
    required super.totalPage,
  });

  CartsuggestionPagingModel.fromJson(Map<String, dynamic> jsn)
      : super.fromJson(jsn) {
    values = buildList(jsn['values']);
  }
  List<CartSuggestionItemEntity> buildList(jsonList) {
    if (jsonList != null) {
      return (jsonList as List)
          .map((e) => CartSuggestionItemModel.fromJson(e))
          .toList();
    }
    return [];
  }
}
