import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/customer_group_data.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/select_messege_method.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/service/cart_suggestion_service.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/service/get_user_service.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CustomerGroupController extends GetxController {
  RequestStatus getStatus = RequestStatus();
  RequestStatus postStatus = RequestStatus();
  String? name;

  CustomerGroupData customerGroupData = CustomerGroupData();
  CustomerGroup? selectedGroup;

  List<Messenger> selectedMessenger = [Messenger.sms];

  bool customerGroupIsExpanded = false;

  @override
  void onInit() {
    super.onInit();
    getCustomers();
  }

  // *----- get customers
  Future getCustomers() async {
    getStatus.loading();
    update(['customers']);
    try {
      ResponseModel response = await GetUserService().getCustomerGroups(
        name: name,
        page: null,
        size: null,
      );
      if (response.isSuccess) {
        customerGroupData = response.data;
        getStatus.success();
        update(['customers']);
      } else {
        getStatus.error(response.message);
        update(['customers']);
      }
    } catch (e) {
      getStatus.error(e.toString());
      update(['customers']);
    }
  }

  void search(String? q) {
    if (q != null && q.isEmpty) {
      name = null;
    } else if (q != null) {
      name = q.toEnglishDigit();
    } else {
      name = q;
    }
    getCustomers();
  }

  void setSelected(CustomerGroup customerGroup) {
    if (customerGroup.id == selectedGroup?.id) {
      selectedGroup = null;
    } else {
      selectedGroup = customerGroup;
    }
    update(['customers']);
  }

  /// *---- sms
  void sendLinkHandler(int cartSuggestionId) async {
    if (selectedGroup != null) {
      postStatus.loading();
      update(['button']);
      try {
        ResponseModel response = await CartSuggestionService().sendLinkToGroup(
            groupId: selectedGroup?.id ?? 0,
            cartSuggestionId: cartSuggestionId);
        if (response.isSuccess) {
          postStatus.success();
          update(['button']);
          Get.back();
          Snacki().GETSnackBar(true, response.message);
        } else {
          postStatus.error(response.message);
          update(['button']);
        }
      } catch (e) {
        postStatus.error(e.toString());
        update(['button']);
      }
    } else {
      Snacki().GETSnackBar(false, 'هیچ گروه مشتری انتخاب نشده است.');
    }
  }

  /// *---- telegram
  void sendLinkHandlerByTelegram(int cartSuggestionId) async {
    if (selectedGroup != null) {
      postStatus.loading();
      update(['button']);
      try {
        ResponseModel response = await CartSuggestionService()
            .sendLinkToGroupByTelegram(
                groupId: selectedGroup?.id ?? 0,
                cartSuggestionId: cartSuggestionId);
        if (response.isSuccess) {
          postStatus.success();
          update(['button']);
          Get.back();
          Snacki().GETSnackBar(true, response.message);
        } else {
          postStatus.error(response.message);
          update(['button']);
        }
      } catch (e) {
        postStatus.error(e.toString());
        update(['button']);
      }
    } else {
      Snacki().GETSnackBar(false, 'هیچ گروه مشتری انتخاب نشده است.');
    }
  }

  /// *-----
  void groupIsExpanded() {
    customerGroupIsExpanded = !customerGroupIsExpanded;
    update(['customers']);
  }
}
