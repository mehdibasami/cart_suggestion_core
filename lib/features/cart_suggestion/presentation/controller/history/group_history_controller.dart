import 'package:cart_suggestion_core/core/model/query_model.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/cart_history_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/service/cart_suggestion_service.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class GroupHistoryController extends GetxController {
  RequestStatus getStatus = RequestStatus();
  RequestStatus postStatus = RequestStatus();
//share loading
  var emptySuggestionSendedList = false.obs;
//sended
  int sendedTotalPage = 1;
  final PagingController<int, CartHistoryModel>
      suggestionSendedUserGroupsPagingController =
      PagingController(firstPageKey: 1);

  Future<void> getSuggestionSendedUserGroups(
      {required int pageKey, required int userGroupId}) async {
    getStatus.loading();
    try {
      ResponseModel response = await CartSuggestionService()
          .getSuggestionSendedUserGroups(
              userGroupId: userGroupId,
              queries: [QueryModel(name: 'page', value: pageKey.toString())]);

      if (response.isSuccess) {
        List<CartHistoryModel> loadedList = [];
        sendedTotalPage = response.data['totalPage'];
        List newItems = [];
        if (response.statusCode != 'notFound') {
          newItems = response.data['values'] as List;
        }

        if (newItems.isEmpty) {
          emptySuggestionSendedList.value = true;
        }
        newItems.forEach((element) {
          loadedList.add(CartHistoryModel.fromJson(element));
        });

        final isLastPage = pageKey >= sendedTotalPage;

        if (isLastPage) {
          suggestionSendedUserGroupsPagingController.appendLastPage(loadedList);
        } else {
          final nextPageKey =
              pageKey + 1;
          suggestionSendedUserGroupsPagingController.appendPage(
              loadedList, nextPageKey);
        }

        getStatus.success();
      } else {
        emptySuggestionSendedList.value = true;
        getStatus.error(response.message);
      }
    } catch (e) {
      emptySuggestionSendedList.value = true;
      getStatus.error(e.toString());
    }
  }

  onPressSuggestionSendedTryAgain() {
    emptySuggestionSendedList(false);
    suggestionSendedUserGroupsPagingController.refresh();
  }
}
