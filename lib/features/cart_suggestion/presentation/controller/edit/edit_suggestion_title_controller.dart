import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/edit/edit_checkall_suggestion.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/service/cart_suggestion_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class EditCartSuggestionController extends GetxController {
  RequestStatus getStatus = RequestStatus();
  // final GlobalKey<FormState> formKey = GlobalKey();
  final txtCtrl = TextEditingController();
  CartSuggestionItemEntity _cartSuggestionItemEntity =
      CartSuggestionItemEntity(details: []);
  CartSuggestionItemParams makeListModel = CartSuggestionItemParams(
      id: null,
      title: '',
      imageUrl: '',
      isAllOrginal: false,
      isActive: false,
      startDate: null,
      endDate: null,
      vehicles: [],
      categories: [],
      brands: [],
      appNames: [],
      details: [],
      image: '');
  List<int> selectedVehicleIds = [];
  List<int> selectedBrandIds = [];
  bool loadCartSuggestion = false;
  DateTime selectedStartDate = DateTime.now();
  DateTime? selectedEndDate;
  List<int> selectedCategoryIds = [];

  setSelctedCategories() {}
  Future getCartSuggestionById({required int cartSuggestionId}) async {
    getStatus.loading();
    update(['cart']);
    try {
      ResponseModel responseModel = await CartSuggestionService()
          .getCartSuggestionById(cartSuggestionId: cartSuggestionId);
      if (responseModel.isSuccess) {
        final data = responseModel.data as Map<String, dynamic>;
        _cartSuggestionItemEntity = CartSuggestionItemModel.fromJson(data);
        makeListModel = CartSuggestionItemParams(
            id: _cartSuggestionItemEntity.id,
            title: _cartSuggestionItemEntity.title ?? '',
            imageUrl: _cartSuggestionItemEntity.imageUrl,
            isAllOrginal: _cartSuggestionItemEntity.isAllOrginal ?? false,
            isActive: _cartSuggestionItemEntity.isActive ?? false,
            startDate: _cartSuggestionItemEntity.startDate,
            endDate: _cartSuggestionItemEntity.endDate,
            vehicles: _cartSuggestionItemEntity.vehicles
                    ?.map((e) => e.vehicleId!)
                    .toList() ??
                    
                [],
            categories: _cartSuggestionItemEntity.categories,
            brands: _cartSuggestionItemEntity.brands
                    ?.map((e) => e.brandId!)
                    .toList() ??
                [],
            appNames: _cartSuggestionItemEntity.appNames
                    ?.map((e) => e.id!)
                    .toList() ??
                [],
            details: _cartSuggestionItemEntity.details ?? [],
            image: _cartSuggestionItemEntity.image ?? '');
        txtCtrl.text = makeListModel.title;
        getStatus.success();
        update(['cart']);
      } else {
        getStatus.error(responseModel.message);
        update(['cart']);
      }
    } catch (e) {
      getStatus.error(e.toString());

      update(['cart']);
    }
  }

  onTapEditProductBtn() {
    {
      if (txtCtrl.text.isNotEmpty) {
        Get.to(() => EditCheckAllSuggestion(
              makeListModel: makeListModel,
            ));
      } else {
        Snacki().GETSnackBar(false, 'لطفا فیلد موضوع را وارد کنید.');
      }
    }
  }
}
