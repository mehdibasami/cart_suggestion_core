import 'package:cart_suggestion_core/features/cart_suggestion/data/model/cart_suggestion_app_names_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/cart_suggestion_brand_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/cart_suggestion_detail_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/cart_suggestion_vehicle_model.dart';

class CartSuggestionItemEntity {
  int? id;
  String? title;
  String imageUrl;
  bool? isAllOrginal;
  bool? isActive;
  DateTime? startDate;
  DateTime? endDate;
  List<int> categories;
  List<CartSuggestionVehicleModel>? vehicles;
  List<CartSuggestionBrandModel>? brands;
  List<CartSuggestionAppNameModel>? appNames;
  List<CartSuggestionDetailModel>? details;
  String? image;

  CartSuggestionItemEntity({
    this.id,
    this.title,
    this.imageUrl = '',
    this.isAllOrginal,
    this.isActive,
    this.categories=const [],
    this.vehicles,
    this.brands,
    this.appNames,
    this.details,
    this.image,
    this.startDate,
    this.endDate,
  });
}
