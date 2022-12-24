import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/service/cart_suggestion_vehicle_service.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CartSuggestionVehicleController extends GetxController {
// *status
  RequestStatus getStatus = RequestStatus();
  RequestStatus deleteStatus = RequestStatus();

  // *model
  CartSuggestionVehiclePagingModel? vehicleModel;

  // *search query
  String? name;

  // *----- get vehicles
  Future getSuggestedVehicles() async {
    getStatus.loading();
    update(['cartSuggestion_vehicle']);
    try {
      ResponseModel response =
          await CartSuggestionVehicleService().getVehicles(name, null, null);
      if (response.isSuccess) {
        vehicleModel = response.data;
        getStatus.success();
        update(['cartSuggestion_vehicle']);
      } else {
        getStatus.error(response.message);
        update(['cartSuggestion_vehicle']);
      }
    } catch (e) {
      getStatus.error(e.toString());
      update(['cartSuggestion_vehicle']);
    }
  }

  // *----- search
  Future search(String? q) async {
    if (q != null && q.isEmpty) {
      name = null;
    } else if (q != null) {
      name = q.toEnglishDigit();
    } else {
      name = q;
    }
    await getSuggestedVehicles();
  }
}
