import 'package:cart_suggestion_core/features/cart_suggestion/data/model/set_item_basket_qty_model.dart';

class SetItemBasketQTYEntity {
  int productId;
  int quantity;
  int paymentWay;
  int suggestionId;

  SetItemBasketQTYEntity(
      {this.productId = 0,
      this.paymentWay = 2,
      this.quantity = 0,
      required this.suggestionId});

  SetItemBasketQTYModel toModel() {
    return SetItemBasketQTYModel(
        productId: productId,
        quantity: quantity,
        paymentWay: paymentWay,
        suggestionId: suggestionId);
  }
}
