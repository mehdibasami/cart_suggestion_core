import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/service/cart_suggestion_service.dart';
import 'package:get/get.dart';


class SubmitCartSuggestionController extends GetxController {
  RequestStatus submitStatus = RequestStatus();
  RequestStatus updateStatus = RequestStatus();

  Future<bool> submit(CartSuggestionItemParams listModel) async {
    bool success = false;
    submitStatus.loading();
    update(['button']);
    try {
      ResponseModel response =
          await CartSuggestionService().submitCartSuggestion(listModel);
      if (response.isSuccess) {
        success = true;
        submitStatus.success(message: 'عملیات با موفقیت انجام شد.');
        update(['button']);
      } else {
        submitStatus.error(response.message);
        update(['button']);
      }
    } catch (e) {
      submitStatus.error(e.toString());
      update(['button']);
    }
    return success;
  }

  Future<bool> updateCartSuggestion(CartSuggestionItemParams  listModel) async {
    bool success = false;
    updateStatus.loading();
    update(['update_button']);
    try {
      ResponseModel response = await CartSuggestionService()
          .updateCartSuggestion(listModel: listModel);
      if (response.isSuccess) {
        
        success = true;
        updateStatus.success(message: 'عملیات با موفقیت انجام شد.');
        update(['update_button']);
      } else {
        updateStatus.error(response.message);
        update(['update_button']);
      }
    } catch (e) {
      updateStatus.error(e.toString());
      update(['update_button']);
    }
    return success;
  }
}
