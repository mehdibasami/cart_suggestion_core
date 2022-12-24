import 'package:cart_suggestion_core/features/cart_suggestion/data/model/cart_suggestion_brand_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/cart_suggestion_vehicle_model.dart';

import './cart_suggestion_detail_model.dart';
import '../../domain/entity/cart_suggestion_item_entity.dart';
import './cart_suggestion_app_names_model.dart';

class CartSuggestionItemModel extends CartSuggestionItemEntity {
  CartSuggestionItemModel({
    required int id,
    required String title,
    required String imageUrl,
    required bool isAllOrginal,
    required bool isActive,
    required DateTime? startDate,
    required DateTime? endDate,
    required List<CartSuggestionVehicleModel>? vehicles,
    required List<int> categories,
    required List<CartSuggestionBrandModel>? brands,
    required List<CartSuggestionAppNameModel>? appNames,
    required List<CartSuggestionDetailModel> details,
    required String image,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          isAllOrginal: isAllOrginal,
          isActive: isActive,
          vehicles: vehicles,
          brands: brands,
          appNames: appNames,
          details: details,
          image: image,
          categories: categories,
          startDate: startDate,
          endDate: endDate,
        );

  //*----- from json
  CartSuggestionItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['imageUrl'] ?? '';
    isAllOrginal = json['isAllOrginal'];
    isActive = json['isActive'];
    startDate =
        json['startDate'] == null ? null : DateTime.parse(json['startDate']);
    endDate = json['endDate'] == null ? null : DateTime.parse(json['endDate']);
    isActive = json['isActive'];

    /// *vehicle
    if (json['vehicles'] != null) {
      vehicles = <CartSuggestionVehicleModel>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(CartSuggestionVehicleModel.fromJson(v));
      });
    }

    /// *categories
    categories = json['categories'] == null
        ? []
        : (json['categories'] as List).map((e) => e).toList().cast<int>();

    /// *brands
    if (json['brands'] != null) {
      brands = <CartSuggestionBrandModel>[];
      json['brands'].forEach((v) {
        brands!.add(CartSuggestionBrandModel.fromJson(v));
      });
    }

    /// *appNames
    if (json['appNames'] != null) {
      appNames = <CartSuggestionAppNameModel>[];
      json['appNames'].forEach((v) {
        appNames!.add(CartSuggestionAppNameModel.fromJson(v));
      });
    }

    /// *details
    if (json['details'] != null) {
      details = <CartSuggestionDetailModel>[];
      json['details'].forEach((v) {
        details!.add(CartSuggestionDetailModel.fromJson(v));
      });
    }

    image = json['image'];
  }

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
    if (vehicles != null) {
      data['vehicles'] = vehicles;
    }

    /// *categories
    data['categories'] = categories;

    /// *brands
    if (brands != null) {
      data['brands'] = brands;
    }

    /// *appNames
    if (appNames != null) {
      data['appNames'] = appNames;
    }

    /// *details
    if (details != null) {
      data['details'] = details;
    }

    data['image'] = image;

    return data;
  }

  //*----- to json
  List<CartSuggestionItemModel>? listFromJson(dynamic json) {
    if (json != null) {
      return json.map<CartSuggestionItemModel>((j) {
        return CartSuggestionItemModel.fromJson(j);
      }).toList();
    }
    return null;
  }
}
