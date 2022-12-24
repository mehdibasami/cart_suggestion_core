import 'package:cart_suggestion_core/features/cart_suggestion/data/model/limitation_model.dart';

import './cart_suggestion_detail_model.dart';

class CartSuggestionItemParams {
  int? id;
  String title;
  String imageUrl;
  bool isAllOrginal;
  bool isActive;
  DateTime? startDate;
  DateTime? endDate;
  List<int> vehicles;
  List<int> categories = [];
  List<int> brands = [];
  List<int> appNames = [];
  List<CartSuggestionDetailModel> details;
  String image;

  CartSuggestionItemParams({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.isAllOrginal,
    required this.isActive,
    required this.startDate,
    required this.endDate,
    required this.vehicles,
    required this.categories,
    required this.brands,
    required this.appNames,
    required this.details,
    required this.image,
  });

  //*----- to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['imageUrl'] = imageUrl;
    data['isAllOrginal'] = isAllOrginal;
    data['isActive'] = isActive;
    data['startDate'] = startDate?.toIso8601String();
    data['endDate'] = endDate?.toIso8601String();

    /// *vehicle
    data['vehicles'] = vehicles;

    /// *categories
    data['categories'] = categories;

    /// *brands
    data['brands'] = brands;

    /// *appNames
    data['appNames'] = appNames;

    /// *details
    data['details'] = details.map((e) => {'productId': e.productId}).toList();

    data['image'] = image;

    return data;
  }
}
