import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/service/cart_suggestion_brand_service.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CartSuggestionBrandController extends GetxController {
  // *status
  RequestStatus getStatus = RequestStatus();
  RequestStatus deleteStatus = RequestStatus();

  // *model
  CartSuggestionBrandPagingModel? brandModel;

  // *search query
  String? name;

  // *----- get brands
  Future getSuggestedBrands() async {
    getStatus.loading();
    update(['cartSuggestion_brand']);
    try {
      ResponseModel response =
          await CartSuggestionBrandService().getBrands(name, null, null);
      if (response.isSuccess) {
        brandModel = response.data;
        getStatus.success();
        update(['cartSuggestion_brand']);
      } else {
        getStatus.error(response.message);
        update(['cartSuggestion_brand']);
      }
    } catch (e) {
      getStatus.error(e.toString());
      update(['cartSuggestion_brand']);
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
    await getSuggestedBrands();
  }
}
