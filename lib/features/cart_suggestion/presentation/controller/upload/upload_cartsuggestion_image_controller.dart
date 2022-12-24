import 'dart:developer';
import 'dart:io';

import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/core/utilities/custom_dialog.dart';
import 'package:cart_suggestion_core/core/utilities/image_input_raw.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/image_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/cart_suggestion_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/service/cart_suggestion_service.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class UploadCartsuggestionImageController extends GetxController {
  final cartSuggService = CartSuggestionService();
  RequestStatus getStatus = RequestStatus();
  RequestStatus uploadStatus = RequestStatus();
  RequestStatus setImageStatus = RequestStatus();
  RequestStatus deleteImageStatus = RequestStatus();
  RequestStatus forceDeleteImageStatus = RequestStatus();
  int imagesTotalPage = 1;
  var selectedImageId = 0.obs;
  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
  final PagingController<int, ImageModel> imageItemsPagingController =
      PagingController(firstPageKey: 1);
  getCartSuggestionImages({
    required int pageKey,
  }) async {
    try {
      ResponseModel response =
          await CartSuggestionService().getCartSuggestionImages(
        page: pageKey,
        size: null,
      );
      if (response.isSuccess) {
        List<ImageModel> loadedList =
            ImageModel().listFromJson(response.data['values']);
        imagesTotalPage = response.data['totalPage'];
        final isLastPage = pageKey >= imagesTotalPage;
        if (isLastPage) {
          imageItemsPagingController.appendLastPage(loadedList);
        } else {
          final nextPageKey = pageKey + 1;
          imageItemsPagingController.appendPage(loadedList, nextPageKey);
        }

        getStatus.success();
        update(['images']);
      } else {
        getStatus.error('Error');
        update(['images']);
      }
    } catch (e) {
      getStatus.error('Error');
      update(['images']);
    }
  }

  onLongPressImage({required int id}) {
    return () {
      if (id == selectedImageId.value) {
        selectedImageId.value = 0;
      } else {
        selectedImageId.value = id;
      }
    };
  }

  onTapImage(
      {required int id, required String imageUrl, required Function goTo}) {
    return () {
      if (id == selectedImageId.value) {
        selectedImageId.value = 0;
      } else {
        goTo();
      }
    };
  }

  onTapUploadIcon() {
    return () async {
      if (uploadStatus.status != Status.Loading) {
        File? selectedFile = await ImageInputRaw.takeVideoAndPicture();
        if (selectedFile != null) {
          uploadStatus.loading();
          update(['upload']);
          try {
            ResponseModel response = await cartSuggService
                .uploadCartSuggestionImage(imageFile: selectedFile);
            if (response.statusCode == '200') {
              uploadStatus.success();
              imageItemsPagingController.refresh();
              update(['upload']);
            } else {
              uploadStatus.error('خطا در آپلود تصویر : ${response.statusCode}');
              update(['upload']);
            }
          } catch (e) {
            uploadStatus.error('خطا در آپلود تصویر : $e');
            update(['upload']);
          }
        }
      }
    };
  }

  onTapDeleteIcon({
    required int cartSuggestionImageId,
  }) async {
    try {
      deleteImageStatus.loading();

      update(['deleteImage$cartSuggestionImageId']);
      ResponseModel response = await cartSuggService.deleteCartSuggestionImage(
          cartSuggestionImageId: cartSuggestionImageId);
      if (response.isSuccess) {
        deleteImageStatus.success();
        update(['deleteImage$cartSuggestionImageId']);
        imageItemsPagingController.refresh();
      } else {
        if (response.statusCode == 'logicError') {
          deleteImageStatus.clear();
          Get.dialog(
            CustomDialog(
              title: 'این تصویر در لینک دیگری استفاده شده است.',
              alertText: 'آیا مطمئن هستید که آن را می خواهید حذف کنید؟',
              onTapYes: () {
                onTapForceDelete(cartSuggestionImageId: cartSuggestionImageId);
              },
            ),
          );
          update(['deleteImage$cartSuggestionImageId']);
        } else {
          deleteImageStatus.error('خطا در حذف : ${response.message}');
          update(['deleteImage$cartSuggestionImageId']);
        }
      }
    } catch (e) {
      deleteImageStatus.error('خطا در حذف : $e');
      update(['deleteImage$cartSuggestionImageId']);
    }
  }

  onTapForceDelete({
    required int cartSuggestionImageId,
  }) async {
    try {
      deleteImageStatus.loading();

      update(['deleteImage$cartSuggestionImageId']);
      Get.back();
      ResponseModel response =
          await cartSuggService.forceDeleteCartSuggestionImage(
              cartSuggestionImageId: cartSuggestionImageId);
      if (response.isSuccess) {
        deleteImageStatus.success();
        update(['deleteImage$cartSuggestionImageId']);
        imageItemsPagingController.refresh();
        Get.find<CartSuggestionController>()
            .cartSuggestionPagingController
            .refresh();
      } else {
        deleteImageStatus.error('خطا در حذف : ${response.message}');
        update(['deleteImage$cartSuggestionImageId']);
      }
    } catch (e) {
      deleteImageStatus.error('خطا در حذف : $e');
      update(['deleteImage$cartSuggestionImageId']);
    }
  }

  onTapSetImageToCartSuggestion(
      {required int cartSuggestionImageId,
      required int cartSuggestionId}) async {
    // log('ID: ${selectedImageId.value}');
    // log('${setImageStatus.status}  && $cartSuggestionImageId  - $cartSuggestionId');
    if (setImageStatus.status != Status.Loading && cartSuggestionImageId != 0) {
      setImageStatus.loading();
      update(['setImageStatus']);
      try {
        ResponseModel response = await cartSuggService.setImageToCartSuggestion(
            cartSuggestionId: cartSuggestionId,
            cartSuggestionImageId: cartSuggestionImageId);
        if (response.isSuccess) {
          setImageStatus.success();
          update(['setImageStatus']);

          Get.back();
          Get.find<CartSuggestionController>()
              .cartSuggestionPagingController
              .refresh();
        } else {
          setImageStatus.error('خطا در آپلود تصویر : ${response.statusCode}');
          update(['setImageStatus']);
        }
      } catch (e) {
        setImageStatus.error('خطا در آپلود تصویر : $e');
        update(['setImageStatus']);
      }
    } else if (cartSuggestionImageId == 0) {
      Snacki().GETSnackBar(false, 'تصویر مورد نظر را انتخاب کنید');
    }
  }
}
