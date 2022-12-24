
import 'package:cart_suggestion_core/features/cart_suggestion/domain/entity/cart_suggestion_brand_entity.dart';

class CartSuggestionBrandModel extends CartSuggestionBrandEntity {
  CartSuggestionBrandModel({
    int? cartSuggestionHeaderId,
    int? brandId,
    String? brandName,
  }) : super(
          cartSuggestionHeaderId: cartSuggestionHeaderId,
          brandId: brandId,
          brandName: brandName,
        );

  /// *----- from json
  CartSuggestionBrandModel.fromJson(Map<String, dynamic> json) {
    cartSuggestionHeaderId = json['cartSuggestionHeaderId'];
    brandId = json['brandId']??json['id'];
    brandName = json['brandName']??json['name'];
  }

  /// *----- to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartSuggestionHeaderId'] = cartSuggestionHeaderId;
    data['brandId'] = brandId;
    data['brandName'] = brandName;
    return data;
  }

  /// *----- list from json
  List<CartSuggestionBrandModel>? listFromJson(dynamic json) {
    if (json != null) {
      return json.map<CartSuggestionBrandModel>((j) {
        return CartSuggestionBrandModel.fromJson(j);
      }).toList();
    }
    return null;
  }
}
