import 'package:cart_suggestion_core/features/cart_suggestion/domain/entity/cart_suggestion_vehicle_entity.dart';

class CartSuggestionVehicleModel extends CartSuggestionVehicleEntity {
  CartSuggestionVehicleModel({
    int? cartSuggestionHeaderId,
    int? vehicleId,
    String? vehicleName,
    String? vehiclePersianName,
  }) : super(
          cartSuggestionHeaderId: cartSuggestionHeaderId,
          vehicleId: vehicleId,
          vehicleName: vehicleName,
          vehiclePersianName: vehiclePersianName,
        );

  //*----- from json
  CartSuggestionVehicleModel.fromJson(Map<String, dynamic> json) {
    cartSuggestionHeaderId = json['cartSuggestionHeaderId'];
    vehicleId = json['vehicleId'] ?? json['id'];
    vehicleName = json['vehicleName'] ?? json['name'];
    vehiclePersianName = json['vehiclePersianName'];
  }

  //*----- to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cartSuggestionHeaderId'] = cartSuggestionHeaderId;
    data['vehicleId'] = vehicleId;
    data['vehicleName'] = vehicleName;
    data['vehiclePersianName'] = vehiclePersianName;
    return data;
  }

  //*----- list from json
  List<CartSuggestionVehicleModel>? listFromJson(dynamic json) {
    if (json != null) {
      return json.map<CartSuggestionVehicleModel>((j) {
        return CartSuggestionVehicleModel.fromJson(j);
      }).toList();
    }
    return null;
  }
}
