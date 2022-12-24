
import 'package:cart_suggestion_core/features/cart_suggestion/domain/entity/cart_suggestion_app_names_entity.dart';

class CartSuggestionAppNameModel extends CartSuggestionAppNamesEntity {
  CartSuggestionAppNameModel({
    int? id,
    String? name,
  }) : super(
          id: id,
          name: name,
        );

  /// *----- from json
  CartSuggestionAppNameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  /// *----- to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  /// *----- list from json
  List<CartSuggestionAppNameModel>? listFromJson(dynamic json) {
    if (json != null) {
      return json.map<CartSuggestionAppNameModel>((j) {
        return CartSuggestionAppNameModel.fromJson(j);
      }).toList();
    }
    return null;
  }
}
