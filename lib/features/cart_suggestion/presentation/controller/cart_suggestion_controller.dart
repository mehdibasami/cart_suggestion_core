import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/model/Api.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/upload_image/upload_cartsuggestion_image_screen.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/service/cart_suggestion_service.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CartSuggestionController extends GetxController {
  // @override
  // void onInit() {
  
  //   super.onInit();
  // }

  // @override
  // void onClose() {
  //   cartSuggestionPagingController.dispose();
  //   super.onClose();
  // }

  // *status
  RequestStatus deleteStatus = RequestStatus();
  RequestStatus getStatus = RequestStatus();
  RequestStatus getCategorieStatus = RequestStatus();
  RequestStatus diactiveStatus = RequestStatus();
  // * category
  var _cartSuggestionCategory = <CartSuggestionCategoryModel>[].obs;
  List<CartSuggestionCategoryModel> get cartSuggestionCategory =>
      _cartSuggestionCategory;
  List<int> selectedCategoryIds = [];
  //* dates
  DateTime selectedStartDate = DateTime.now();
  DateTime? selectedEndDate;
  // *search query
  String? name;
  // *filter query
  List<int>? brandIds = [];
  List<int>? vehicleIds = [];
  // List<BillValueModel> cartSuggestionItems = [];
//totalpages
  int cartSuggTotalPage = 1;
//PAGING Ctrl
  final PagingController<int, CartSuggestionItemEntity>
      cartSuggestionPagingController = PagingController(firstPageKey: 1);
// *----- get cart suggestion categry

  void getCartSuggestionCategory() async {
    try {
      ResponseModel response =
          await CartSuggestionService().getCartSuggestionCategory();
      if (response.isSuccess) {
        _cartSuggestionCategory.value = response.data;
      } else {
        getCategorieStatus
            .error('خطای ${response.statusCode} ${response.message}');
      }
    } catch (e) {
      Api.printError('catch error: $e');
      getCategorieStatus.error('$e');
    }
  }

// *----- get cart suggestion
  Future getSuggestion({
    required int pageKey,
  }) async {
    deleteStatus.loading();
    try {
      ResponseModel response = await CartSuggestionService().getCartSuggestion(
        filter: name,
        page: pageKey,
        size: null,
        brandIds: brandIds,
        vehicleIds: vehicleIds,
      );
      if (response.isSuccess) {
        CartsuggestionPagingModel cartPagingEntity =
            CartsuggestionPagingModel.fromJson(response.data);
        cartSuggTotalPage = cartPagingEntity.totalPage;

        final isLastPage = pageKey >= cartSuggTotalPage;
        
        if (isLastPage) {
          cartSuggestionPagingController
              .appendLastPage(cartPagingEntity.values);
        } else {
          final nextPageKey =
              pageKey + 1;
          cartSuggestionPagingController.appendPage(
              cartPagingEntity.values, nextPageKey);
        }
        deleteStatus.success();

        // update(['cartS']);
      } else {
        deleteStatus.error(response.message);
        // update(['cartS']);
        cartSuggestionPagingController
            .notifyStatusListeners(PagingStatus.firstPageError);
      }
    } catch (e) {
      deleteStatus.error(e.toString());
      cartSuggestionPagingController
          .notifyStatusListeners(PagingStatus.firstPageError);
      // update(['cartS']);
    }
  }

  onTapCartSuggImage(
      {required int? cartSuggestionId, required String cartSuggestionTitle}) {
    return () {
      Get.to(() => UploadCartSuggestionImageScreen(
            cartSuggestionId: cartSuggestionId,
            cartSuggestionTitle: cartSuggestionTitle,
          ));
    };
  }

  void search(String? q) {
    if (q != null && q.isEmpty) {
      name = null;
    } else if (q != null) {
      name = q.toEnglishDigit();
    } else {
      name = q;
    }
    cartSuggestionPagingController.refresh();
  }

  // *----- brand filter
  void filterBrand(List<int> brands) {
    if (brands.isEmpty) {
      brandIds = null;
    } else {
      brandIds = brands;
    }
    cartSuggestionPagingController.refresh();
  }

  // *----- veficle filter
  void filterVehicle(List<int> vehicles) {
    if (vehicles.isEmpty) {
      vehicleIds = null;
    } else {
      vehicleIds = vehicles;
    }
    cartSuggestionPagingController.refresh();
  }

  /// *----- delete cart suggestion
  deleteCartSuggestion(int id) async {
    deleteStatus.loading();
    update(['delete$id']);
    try {
      ResponseModel response =
          await CartSuggestionService().deleteCartSuggestion(id);
      if (response.isSuccess) {
        cartSuggestionPagingController.refresh();
        deleteStatus.success();
        update(['delete$id']);
      } else {
        deleteStatus.error(response.message);
        update(['delete$id']);
      }
    } catch (e) {
      deleteStatus.error(e.toString());
      update(['delete$id']);
    }
  }

  /// *----- diactive cart suggestion
  Future diactiveCartSuggestion(int id) async {
    diactiveStatus.loading();
    update(['delete$id']);
    try {
      ResponseModel response =
          await CartSuggestionService().disableCartSuggestion(id);
      if (response.isSuccess) {
        // cartSuggestionPagingController.itemList
        //     ?.removeWhere((element) => element.id == id);
        cartSuggestionPagingController.refresh();
        diactiveStatus.success();
        update(['delete$id', 'cartS']);
      } else {
        diactiveStatus.error(response.message);
        update(['delete$id']);
      }
    } catch (e) {
      diactiveStatus.error(e.toString());
      update(['delete$id']);
    }
  }

  /// *----- enable cart suggestion
  Future enableCartSuggestion(int id) async {
    diactiveStatus.loading();
    update(['delete$id']);
    try {
      ResponseModel response =
          await CartSuggestionService().enableCartSuggestion(id);
      if (response.isSuccess) {
        cartSuggestionPagingController.refresh();
        diactiveStatus.success();
        update(['delete$id', 'cartS']);
      } else {
        diactiveStatus.error(response.message);
        update(['delete$id']);
      }
    } catch (e) {
      diactiveStatus.error(e.toString());
      update(['delete$id']);
    }
  }
  int calculateBundleQty({
    required int realQty,
    required int quantity,
    required int bundleQty,
  }) {
    return ((realQty / quantity) * bundleQty).toInt();
  }
  onTapTryAgain() {
    deleteStatus.loading();
    update(['cartS']);
    cartSuggestionPagingController.refresh();
  }
}
