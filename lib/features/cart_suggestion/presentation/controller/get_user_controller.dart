import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/get_user_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/get_user_value_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/make_customer_group.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/service/get_user_service.dart';

import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';


class GetUserController extends GetxController {
  // *status
  RequestStatus getStatus = RequestStatus();
  RequestStatus disableStatus = RequestStatus();
  RequestStatus postStatus = RequestStatus();
  final List<GetUserValueModel> selectedCustomer = [];

  // *model
  GetUserModel? getUserModel;

  // *name query
  String? name;

  ///
  bool customerIsExpanded = false;

  // *----- get users
  Future getUsers() async {
    getStatus.loading();
    update(['users']);
    try {
      ResponseModel response = await GetUserService()
          .getUsers(name: name, page: null, size: null, profileType: null);
      if (response.isSuccess) {
        getUserModel = response.data;
        getStatus.success();
        update(['users']);
      } else {
        getStatus.error(response.message);
        update(['users']);
      }
    } catch (e) {
      getStatus.error(e.toString());
      update(['users']);
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
    getUsers();
  }

  void selectHandler(GetUserValueModel customer, bool isSelected) {
    if (!isSelected) {
      selectedCustomer.add(customer);
    } else {
      selectedCustomer.removeWhere((element) => element.id == customer.id);
    }
    update(['users']);
  }

  Future<bool> createNewGroup(MakeCustomerGroup makeCustomerGroup) async {
    bool success = false;
    if (selectedCustomer.isNotEmpty) {
      postStatus.loading();
      update(['button']);
      try {
        makeCustomerGroup.userIds =
            selectedCustomer.map((e) => e.id ?? 0).toList();
        ResponseModel response =
            await GetUserService().createUserGroup(makeCustomerGroup);
        success = response.isSuccess;
        if (response.isSuccess) {
          postStatus.success();
          update(['button']);
        } else {
          postStatus.error(response.message);
          update(['button']);
        }
      } catch (e) {
        postStatus.error(e.toString());
        update(['button']);
      }
    } else {
      Snacki().GETSnackBar(false, 'هیچ مشتری انتخاب نشده است.');
    }
    return success;
  }

  Future<bool> disableUserGroup({required int userGroupId}) async {
    bool success = false;
    disableStatus.loading();
    update(['$userGroupId']);
    try {
      ResponseModel response =
          await GetUserService().disableUserGroup(userGroupId: userGroupId);
      if (response.isSuccess) {
        success = true;
        disableStatus.success();
        update(['$userGroupId']);
      } else {
        disableStatus.error(response.message);
        update(['$userGroupId']);
      }
    } catch (e) {
      disableStatus.error(e.toString());
      update(['$userGroupId']);
    }
    return success;
  }

  /// *-----
  void groupIsExpanded() {
    customerIsExpanded = !customerIsExpanded;
    update(['users']);
  }
}
