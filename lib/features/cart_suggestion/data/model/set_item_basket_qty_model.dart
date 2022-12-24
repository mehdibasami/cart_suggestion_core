import 'package:cart_suggestion_core/features/cart_suggestion/domain/entity/set_item_basket_qty_entity.dart';

class SetItemBasketQTYModel extends SetItemBasketQTYEntity {
  SetItemBasketQTYModel({
    int? productId,
    int? quantity,
    int? paymentWay,
    required int suggestionId,
  }) : super(
          productId: productId ?? 0,
          quantity: quantity ?? 0,
          paymentWay: paymentWay ?? 2,
          suggestionId: suggestionId,
        );

  factory SetItemBasketQTYModel.fromJson(Map<String, dynamic> json) {
    return SetItemBasketQTYModel(
        paymentWay: json['paymentWay'],
        productId: json['productId'],
        quantity: json['quantity'],
        suggestionId: json['suggestionId']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = quantity;
    data['paymentWay'] = paymentWay;
    data['suggestionId'] = suggestionId;
    return data;
  }
}
