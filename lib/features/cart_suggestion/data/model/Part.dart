import 'package:cart_suggestion_core/features/cart_suggestion/data/model/vehicle.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/product.dart';

class Part {
  // String? partNumber;
  String? appName;
  String? name;
  String? familyTitle;
  String? thumbImagePath;
  String? partImage;
  List<Product>? products;
  List<Vehicle>? vehicles;
  List<Part>? family;
  List<String>? partNumbers;
  int? id;
  String? vehiclePersianName;
  String? vehicleEnglishName;

  Part({
    // this.partNumber,
    this.appName,
    this.name,
    this.familyTitle,
    this.products,
    this.thumbImagePath,
    this.vehicles,
    this.family,
    this.partNumbers,
    this.partImage,
    this.id,
    this.vehiclePersianName,
    this.vehicleEnglishName,
  });

  Part.fromJson(Map<String, dynamic> json) {
    // partNumber = json['partNumber'] ?? "";
    name = json['name'] ?? "";
    appName = json['appName'] ?? "";
    familyTitle = json['familyTitle'] ?? "";
    partImage = json['partImage'] ?? "";
    thumbImagePath = json['thumbImagePath'] ?? "";
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    if (json['families'] != null) {
      family = [];
      json['families'].forEach((v) {
        family!.add(Part.fromJson(v));
      });
    }
    if (json['partNumbers'] != null) {
      partNumbers = [];
      json['partNumbers'].forEach((v) {
        partNumbers!.add(v);
      });
    }
    if (json['vehicles'] != null) {
      vehicles = [];
      json['vehicles'].forEach((v) {
        vehicles!.add(new Vehicle.fromJson(v));
      });
    }
    id = json['id'] ?? 0;
    vehiclePersianName = json['vehiclePersianName'] ?? "";
    vehicleEnglishName = json['vehicleEnglishName'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['partNumber'] = this.partNumber;
    data['name'] = this.name;
    data['familyTitle'] = this.familyTitle;
    data['thumbImagePath'] = this.thumbImagePath;
    data['partImage'] = this.partImage;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.family != null) {
      data['families'] = this.family!.map((v) => v.toJson()).toList();
    }
    if (this.vehicles != null) {
      data['vehicles'] = this.vehicles!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['vehiclePersianName'] = this.vehiclePersianName;
    data['vehicleEnglishName'] = this.vehicleEnglishName;
    return data;
  }

  List<Part>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Part>((ct) {
        return Part.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
