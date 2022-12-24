import 'package:cart_suggestion_core/cart_suggestion_core.dart';

class PartWithDetailModel {
  int? id;
  String? name;
  String? appName;
  String? partNumber;
  String? familyTitle;
  double? orderManual;
  String? partImage;
  String? thumbImagePath;
  int? categoryId;
  String? categoryName;
  int? categoryParentId;
  String? vehicleEnglishName;
  String? vehiclePersianName;
  String? saleRolesGroupId;
  int? saleRoleTypesId;
  int? productTotalBought;
  // List<PartWithDetailFamilyModel>? families;
  List<CartSuggestionDetailModel>? products;

  PartWithDetailModel({
    this.id,
    this.name,
    this.appName,
    this.partNumber,
    this.familyTitle,
    this.orderManual,
    this.partImage,
    this.thumbImagePath,
    this.categoryId,
    this.categoryName,
    this.categoryParentId,
    this.vehicleEnglishName,
    this.vehiclePersianName,
    this.saleRolesGroupId,
    this.saleRoleTypesId,
    this.productTotalBought,
    // this.families,
    this.products,
  });

  /// *----- from json
  PartWithDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    appName = json['appName'];
    partNumber = json['partNumber'];
    familyTitle = json['familyTitle'];
    orderManual = json['orderManual'];
    partImage = json['partImage'];
    thumbImagePath = json['thumbImagePath'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    categoryParentId = json['categoryParentId'];
    vehicleEnglishName = json['vehicleEnglishName'];
    vehiclePersianName = json['vehiclePersianName'];
    saleRolesGroupId = json['saleRolesGroupId'];
    saleRoleTypesId = json['saleRoleTypesId'];
    productTotalBought = json['productTotalBought'];
    // families = json['families'];
    if (json['products'] != null) {
      products = <CartSuggestionDetailModel>[];
      json['products'].forEach((v) {
        products!.add( CartSuggestionDetailModel.fromJson(v));
      });
    }
  }

  /// *----- to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['appName'] = this.appName;
    data['partNumber'] = this.partNumber;
    data['familyTitle'] = this.familyTitle;
    data['orderManual'] = this.orderManual;
    data['partImage'] = this.partImage;
    data['thumbImagePath'] = this.thumbImagePath;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['categoryParentId'] = this.categoryParentId;
    data['vehicleEnglishName'] = this.vehicleEnglishName;
    data['vehiclePersianName'] = this.vehiclePersianName;
    data['saleRolesGroupId'] = this.saleRolesGroupId;
    data['saleRoleTypesId'] = this.saleRoleTypesId;
    data['productTotalBought'] = this.productTotalBought;
    // data['families'] = this.families;
    if (this.products != null) {
      data['products'] = this.products!.map((e) => e.toJson()).toList();
    }
    return data;
  }

  ///*----- list from json
  List<PartWithDetailModel>? listFromJson(List<dynamic>? json) {
    if (json != null) {
      return json.map<PartWithDetailModel>((j) {
        return PartWithDetailModel.fromJson(j);
      }).toList();
    }
    return null;
  }
}
