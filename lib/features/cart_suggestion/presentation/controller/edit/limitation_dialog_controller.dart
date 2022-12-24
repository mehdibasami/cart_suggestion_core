import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/limitation_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/service/ProductInfoService.dart';

import 'package:get/get.dart';

class LimitationDialogController extends GetxController {
  var limitations = <Limitation>[];
  // set limitations(List<Limitation> value) => this._limitations.value = value;
  // List<Limitation> get limitations => this._limitations;
  RequestStatus editStatus = RequestStatus();
  // onTapConfirmBtn(List<Limitation> limitations) {
  //   editProductLimitations(limitations: this.limitations);
  // }

  Future<bool> editProductLimitations(
      {required List<Limitation> mainLimitations}) async {
    editStatus.loading();
    update();
    try {
      ResponseModel responseModel = await ProductInfoService()
          .editProductLimitations(limitations: this.limitations);
      if (responseModel.isSuccess) {
        editStatus.success();
        update();
        Get.back();
        Snacki().GETSnackBar(true, responseModel.message);

        return true;
      } else {
        editStatus.error(responseModel.message);
        update();
        return false;
      }
    } catch (e) {
      editStatus.error('server error!');
      update();
      return false;
    }
  }
}
