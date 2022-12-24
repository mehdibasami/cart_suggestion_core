import 'package:cart_suggestion_core/core/model/query_model.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/cart_history_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/service/cart_suggestion_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class CartHistoryController extends GetxController {
  RequestStatus getStatus = RequestStatus();
  RequestStatus postStatus = RequestStatus();
//share loading
  bool loadingShareBtn = false;
  var emptySendedList = false.obs;
  var emptyNotSendedList = false.obs;
//sended
  int sendedTotalPage = 1;
//not sended
  int notSendedTotalPage = 1;
  final PagingController<int, CartHistoryModel> sendedPagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, CartHistoryModel> notSendedPagingController =
      PagingController(firstPageKey: 1);
  onPressShareBtn(
      {required int cartSuggestionId, required int selectedGroupId}) {
    return () {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return AlertDialog(
              title: Text('ارسال برای گروه'),
              content: Text('مطمئن هستید؟'),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('خیر',
                        style: TextStyle(color: CBase().dinawinBrown))),
                TextButton(
                    onPressed: () async {
                      Get.back();

                      loadingShareBtn = true;
                      update(['$selectedGroupId']);
                      await sendLinkHandler(
                          cartSuggestionId: cartSuggestionId,
                          selectedGroupId: selectedGroupId);
                      loadingShareBtn = false;
                      update(['$selectedGroupId']);
                    },
                    child: Text('بله',
                        style: TextStyle(color: CBase().dinawinBrown))),
              ],
            );
          });
    };
  }

  Future<void> getUserGroupsRecivedSuggestion(
      {required int pageKey, required int cartSuggestionId}) async {
    getStatus.loading();
    try {
      ResponseModel response = await CartSuggestionService()
          .getUserGroupsRecivedSuggestion(
              cartSuggestionId: cartSuggestionId,
              queries: [QueryModel(name: 'page', value: pageKey.toString())]);

      if (response.isSuccess) {
        List<CartHistoryModel> loadedList = [];
        sendedTotalPage = response.data['totalPage'];
        List newItems = [];
        if (response.statusCode != 'notFound') {
          newItems = response.data['values'] as List;
        }

        if (newItems.isEmpty) {
          emptySendedList.value = true;
        }
        newItems.forEach((element) {
          loadedList.add(CartHistoryModel.fromJson(element));
        });

        final isLastPage = pageKey >= sendedTotalPage;

        if (isLastPage) {
          sendedPagingController.appendLastPage(loadedList);
        } else {
          final nextPageKey =
             1;
          sendedPagingController.appendPage(loadedList, nextPageKey);
        }

        getStatus.success();
      } else {
        emptySendedList.value = true;
        getStatus.error(response.message);
      }
    } catch (e) {
      emptySendedList.value = true;
      getStatus.error(e.toString());
    }
  }

  Future<void> getUserGroupsNotSendedSuggestion(
      {required int pageKey, required int cartSuggestionId}) async {
    getStatus.loading();
    try {
      ResponseModel response = await CartSuggestionService()
          .getUserGroupsNotSendedSuggestion(
              cartSuggestionId: cartSuggestionId,
              queries: [
            QueryModel(name: 'page', value: pageKey.toString()),
          ]);
      if (response.isSuccess) {
        List<CartHistoryModel> loadedList = [];
        notSendedTotalPage = response.data['totalPage'];
        List newItems = [];
        if (response.statusCode != 'notFound') {
          newItems = response.data['values'] as List;
        }
        if (newItems.isEmpty) {
          emptyNotSendedList.value = true;
        }
        newItems.forEach((element) {
          loadedList.add(CartHistoryModel.fromJson(element));
        });
        final isLastPage = pageKey >= notSendedTotalPage;

        if (isLastPage) {
          notSendedPagingController.appendLastPage(loadedList);
        } else {
          final nextPageKey =
              pageKey +1;

          notSendedPagingController.appendPage(loadedList, nextPageKey);
        }

        getStatus.success();
      } else {
        emptyNotSendedList.value = true;

        getStatus.error(response.message);
      }
    } catch (e) {
      emptyNotSendedList.value = true;

      getStatus.error(e.toString());
    }
  }

  Future<void> sendLinkHandler(
      {required int cartSuggestionId, required int selectedGroupId}) async {
    postStatus.loading();
    try {
      ResponseModel response = await CartSuggestionService().sendLinkToGroup(
          groupId: selectedGroupId, cartSuggestionId: cartSuggestionId);
      if (response.isSuccess) {
        postStatus.success();
        Snacki().GETSnackBar(true, response.message);
        //refresh lists
        notSendedPagingController.refresh();
        getUserGroupsRecivedSuggestion(
            pageKey: 1, cartSuggestionId: cartSuggestionId);
        emptySendedList(false);
        //end refresh lists
      } else {
        postStatus.error(response.message);
      }
    } catch (e) {
      postStatus.error(e.toString());
    }
  }

  onPressSendedTryAgain() {
    emptySendedList(false);
    sendedPagingController.refresh();
  }

  onPressNotSendedTryAgain() {
    emptyNotSendedList(false);
    notSendedPagingController.refresh();
  }
}
