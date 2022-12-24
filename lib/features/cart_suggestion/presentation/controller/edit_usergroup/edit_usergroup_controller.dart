import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/customer_group_data.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/service/get_user_service.dart';
import 'package:get/get.dart';


class EditUserGroupController extends GetxController {
  RequestStatus getUsersStatus = RequestStatus();
  RequestStatus deleteStatus = RequestStatus();
  RequestStatus addUsersStatus = RequestStatus();
  String? name;

  CustomerGroup selectedGroup = CustomerGroup();
  List<CustomerModel> selectedGroupItemsFiltered = [];

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // *----- get users
  Future getUsersOfGroup({
    required int groupId,
  }) async {
    getUsersStatus.loading();
    update(['getUsersStatus']);
    try {
      ResponseModel response =
          await GetUserService().getUsersOfGroup(groupId: groupId);
      if (response.isSuccess) {
        selectedGroup = response.data;
        selectedGroupItemsFiltered = selectedGroup.items ?? [];
        getUsersStatus.success();
        update(['getUsersStatus']);
      } else {
        getUsersStatus.error(response.message);
        update(['getUsersStatus']);
      }
    } catch (e) {
      getUsersStatus.error(e.toString());
      update(['getUsersStatus']);
    }
  }

  void search(String? value) {
    if (value != null && selectedGroup.items != null) {
      value.isEmpty
          ? selectedGroupItemsFiltered =
              selectedGroup.items!.where((element) => 1 == 1).toList()
          : selectedGroupItemsFiltered = selectedGroup.items!
              .where((element) => 1 == 1)
              .toList()
              .where((user) =>
                  user.fullName!.toLowerCase().contains(value.toLowerCase()))
              .toList();
    }

    update(['getUsersStatus']);
    // getUsersOfGroup();
  }

  onTapRemove({required int userItemId, int? groupId}) {
    return () async {
      deleteStatus.loading();
      update(['$userItemId']);
      try {
        ResponseModel response =
            await GetUserService().removeUserGroupItem(userItemId: userItemId);
        if (response.isSuccess) {
          deleteStatus.success();
          update(['$userItemId']);

          if (groupId != null) {
            getUsersOfGroup(groupId: groupId);
          }
        } else {
          update(['$userItemId']);

          deleteStatus.error(response.message);
        }
      } catch (e) {
        update(['$userItemId']);

        deleteStatus.error(e.toString());
      }
    };
  }

  addUsersToGroup({required int groupId, required List<int> userIds}) async {
    addUsersStatus.loading();
    update(['addUsersStatus']);
    List<Map> usersOfGroupsToAdd = [];
    for (var userId in userIds) {
      usersOfGroupsToAdd.add({
        'userId': userId,
        'userGroupId': groupId,
      });
    }

    try {
      ResponseModel response =
          await GetUserService().addUserGroupItem(data: usersOfGroupsToAdd);
      if (response.isSuccess) {
        addUsersStatus.success();
        update(['addUsersStatus']);
        Get.back();
        Get.back();
        getUsersOfGroup(groupId: groupId);
      } else {
        addUsersStatus.error(response.message);
        update(['addUsersStatus']);
      }
    } catch (e) {
      addUsersStatus.error(e.toString());
      update(['addUsersStatus']);
    }
  }
}
