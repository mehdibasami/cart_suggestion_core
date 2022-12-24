class CartSuggestionCategoryModel {
  CartSuggestionCategoryModel({
    required this.id,
    required this.name,
  });
  late final int id;
  late final String name;

  CartSuggestionCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

 static List<CartSuggestionCategoryModel> toList({required List dynamicList}) {
    final data = <CartSuggestionCategoryModel>[];
    for (var element in dynamicList) {
      data.add(CartSuggestionCategoryModel.fromJson(element));
    }
    return data;
  }
}
