import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/part.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/SearchPart.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/service/balanceService.dart';
import 'package:get/get.dart';



class EditSuggestionProductsController extends GetxController {
  List<SearchPart> searchedItems = [];
  List<SearchPart> selectedItem = [];
  List<SendingProduct> sendProduct = [];
  List<Part> searchedParts = [];
  String overlayErrorText = '';
  String itemsErrorText = '';
  RequestStatus productStatus = RequestStatus();
  RequestStatus itemsStatus = RequestStatus();

  searchParts(
      {required String searchText,
      required List<int> vehicleIds,
      required List<int> brandIds}) async {
    if (searchText.isNotEmpty) {
      productStatus.loading();
      overlayErrorText = '';
      update(['loading_search']);

      // update(['error']);
      ResponseModel result = await BalanceServiceV2().quickSearch(
          search: searchText, vehicleIds: vehicleIds, brandIds: brandIds);

      if (result.isSuccess == false) {
        overlayErrorText = result.message;
        productStatus.error(overlayErrorText);

        update(['loading_search']);
      } else {
        searchedItems = result.data;
        if (searchedItems.isEmpty) {
          overlayErrorText = 'موردی یافت نشد';
        }
        productStatus.success();
        update(['loading_search']);
      }
    } else {
      overlayErrorText = 'عبارت مورد نظر را در کادر بالا تایپ کنید';
      update(['loading_search']);
    }
  }

  addItem(SearchPart item) {
    selectedItem.add(item);
    update(['searchItem']);
  }

  removeItem(SearchPart item) {
    selectedItem.remove(item);
    update(['searchItem']);
  }

  confirm() async {
    await getPart();
  }

  getPart() async {
    List<String> partNumber = [];

    selectedItem.forEach((element) {
      if (element.partNumber != null) {
        partNumber.add(element.partNumber!);
      }
    });

    try {
      if (partNumber.length != 0) {
        itemsStatus.loading();
        update(['items']);
        await BalanceServiceV2()
            .getSelectedBalanceData(null, partNumber, null, null)
            .then((value) {
          partNumber.clear();
          if (value.isSuccess) {
            if (value.data == null) {
              itemsErrorText = 'مشکلی در برقراری ارتباط با سرور بوجود آمده است';
            } else if (value.data.length == 0) {
              itemsErrorText = 'اطلاعات این محصول ناقص میباشد.';
            }
            searchedParts = value.data;
            itemsStatus.success();
            update(['items']);
          } else {
            itemsStatus.error(value.message);
            value.showMessage();
          }
        });
      }
    } catch (e) {
      Snacki().GETSnackBar(false, 'خطایی در ارتباط با سرور بوجود آمده است');
    }
    // finally {
    // itemsErrorText = "کالای مورد نظر را انتخاب کنید";
    // itemsStatus.error(itemsErrorText);
    update(['items']);
    // }
  }

  updateClear() {
    update(['clear']);
  }

  delProductItem(int productId, int qty) {
    bool check = checkItemIsAdded(productId);

    if (check) {
      if (qty == 0) {
        sendProduct.forEach((element) {
          if (element.productId == productId) {
            sendProduct.remove(element);
          }
        });
      }
    }
  }

  addProductItem(int productId, int qty) {
    bool check = checkItemIsAdded(productId);

    if (check) {
      sendProduct.forEach((element) {
        if (element.productId == productId) {
          element.suggestQTY = qty;
        }
      });
    } else {
      sendProduct.add(SendingProduct(productId: productId, suggestQTY: qty));
    }
  }

  bool checkItemIsAdded(int productId) {
    bool check = false;
    sendProduct.forEach((element) {
      if (element.productId == productId) {
        check = true;
      }
    });
    return check;
  }

  void deleteItem(CartSuggestionDetailEntity item) {
    sendProduct.removeWhere((e) => e.productId == item.productId);
    update(['remove_item']);
  }
}

class SendingProduct {
  int? productId;
  int? suggestQTY;

  SendingProduct({
    this.productId,
    this.suggestQTY,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['productId'] = this.productId;
    data['suggestQTY'] = this.suggestQTY;

    return data;
  }
}
