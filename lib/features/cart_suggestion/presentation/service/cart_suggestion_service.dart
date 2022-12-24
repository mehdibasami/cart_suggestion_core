import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cart_suggestion_core/core/model/Api.dart';
import 'package:cart_suggestion_core/core/model/enum.dart';
import 'package:cart_suggestion_core/core/model/query_model.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/core/values/Routing/RoutingCartSuggestion.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/overlay_search_controller.dart';
import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartSuggestionService extends Api {
  //
  //*----- get cart suggestion
  Future<ResponseModel> getCartSuggestion({
    String? filter,
    int? page,
    int? size,
    List<int>? brandIds,
    List<int>? vehicleIds,
    bool showDisables = true,
    bool onlyDisables = false,
  }) async {
    List<QueryModel> queries = [];
    if (filter != null) {
      queries.add(QueryModel(name: 'filter', value: filter));
    }
    if (page != null) {
      queries.add(QueryModel(name: 'page', value: page.toString()));
    }
    if (size != null) {
      queries.add(QueryModel(name: 'size', value: size.toString()));
    }

    if (brandIds != null && brandIds.isNotEmpty) {
      brandIds.forEach((element) {
        queries.add(QueryModel(name: 'brandIds', value: element.toString()));
      });
    }
    if (vehicleIds != null && vehicleIds.isNotEmpty) {
      vehicleIds.forEach((element) {
        queries.add(QueryModel(name: 'vehicleIds', value: element.toString()));
      });
    }

    queries
        .add(QueryModel(name: 'showDisables', value: showDisables.toString()));

    queries
        .add(QueryModel(name: 'onlyDisables', value: onlyDisables.toString()));

    ResponseModel response = await HTTPGET(
      RoutingCartSuggestion.ALL_CartSuggestion,
      queries,
      null,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    return response;
  }

  /// get images
  Future<ResponseModel> getCartSuggestionImages({
    int? page,
    int? size,
  }) async {
    List<QueryModel> queries = [];

    if (page != null) {
      queries.add(QueryModel(name: 'page', value: page.toString()));
    }
    if (size != null) {
      queries.add(QueryModel(name: 'size', value: size.toString()));
    }
    ResponseModel response = await HTTPGET(
      RoutingCartSuggestion.getCartSuggestionImages,
      queries,
      null,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return response;
  }

  /// upload cart image
  Future<ResponseModel> uploadCartSuggestionImage(
      {required File imageFile}) async {
    var header = Api().bearerHeader;
    var request = http.MultipartRequest(
        'POST', Uri.parse(RoutingCartSuggestion.uploadCartSuggestionImage));
    request.files.add(await http.MultipartFile.fromPath(
        'CartSuggestionImage', imageFile.path));
    request.headers.addAll(header);

    http.StreamedResponse response = await request.send();

    return ResponseModel(
      statusCode: '${response.statusCode}',
    );
  }

  /// set cart image
  Future<ResponseModel> setImageToCartSuggestion(
      {required int cartSuggestionImageId,
      required int cartSuggestionId}) async {
    var body = jsonEncode({
      "cartSuggestionId": cartSuggestionId,
      "cartSuggestionImageId": cartSuggestionImageId,
    });
    ResponseModel response = await HTTPPOST(
      RoutingCartSuggestion.setImageToCartSuggestion,
      [],
      body,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return response;
  }

  /// delete cart image
  Future<ResponseModel> deleteCartSuggestionImage({
    required int cartSuggestionImageId,
  }) async {
    ResponseModel response = await HTTPDELETE(
      RoutingCartSuggestion.deleteCartSuggestionImage,
      [],
      '$cartSuggestionImageId',
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return response;
  }

  ///force delete cart image
  Future<ResponseModel> forceDeleteCartSuggestionImage({
    required int cartSuggestionImageId,
  }) async {
    ResponseModel response = await HTTPDELETE(
      RoutingCartSuggestion.forceDeleteCartSuggestionImage,
      [],
      '$cartSuggestionImageId',
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return response;
  }

  //*-----
  Future<ResponseModel> sendLink(
      {required List<int> userIds, required int cartSuggestionId}) async {
    var body = jsonEncode({
      "cartSuggestionId": cartSuggestionId,
      "userIds": userIds,
    });
    ResponseModel response = await HTTPPOST(
      RoutingCartSuggestion.Post_SendCartSuggestion,
      [],
      body,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return response;
  }

  /// *----- delete cart suggestion
  Future<ResponseModel> deleteCartSuggestion(int? id) async {
    List<QueryModel> queries = [];
    if (id != null) {
      queries.add(QueryModel(name: 'id', value: id.toString()));
    }
    ResponseModel response = await HTTPDELETE(
      RoutingCartSuggestion.ALL_CartSuggestion,
      queries,
      '$id',
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    return response;
  }

  /// *----- delete cart suggestio
  Future<ResponseModel> disableCartSuggestion(int id) async {
    ResponseModel response = await HTTPPUT(
      RoutingCartSuggestion.PUT_DisableCartSuggestion + '/$id',
      [],
      id.toString(),
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    return response;
  }

  /// *----- enable cart suggestio
  Future<ResponseModel> enableCartSuggestion(int id) async {
    ResponseModel response = await HTTPPUT(
      RoutingCartSuggestion.PUT_EnableCartSuggestion + '/$id',
      [],
      id.toString(),
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    return response;
  }

  Future<ResponseModel> submitCartSuggestion(
      CartSuggestionItemParams listModel) async {
    var body = jsonEncode(listModel);
    ResponseModel response = await HTTPPOST(
      RoutingCartSuggestion.ALL_CartSuggestion,
      [],
      body,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (Get.isRegistered<OverlaySearchController>()) {
      Get.delete<OverlaySearchController>();
    }

    return response;
  }

  /// *----- sms
  Future<ResponseModel> sendLinkToGroup(
      {required int groupId, required int cartSuggestionId}) async {
    var body = jsonEncode({
      "cartSuggestionId": cartSuggestionId,
      "userGroupId": groupId,
    });
    ResponseModel response = await HTTPPOST(
      RoutingCartSuggestion.Post_SendCartSuggestion,
      [],
      body,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    return response;
  }

  /// *----- telegram
  Future<ResponseModel> sendLinkToGroupByTelegram(
      {required int groupId, required int cartSuggestionId}) async {
    var body = jsonEncode({
      "cartSuggestionId": cartSuggestionId,
      "userGroupId": groupId,
    });
    ResponseModel response = await HTTPPOST(
      RoutingCartSuggestion.Post_SendCartSuggestionToUserGroupByTelegram,
      [],
      body,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    return response;
  }

  /// *-----
  Future<ResponseModel> getUserGroupsRecivedSuggestion(
      {required int cartSuggestionId,
      List<QueryModel> queries = const []}) async {
    ResponseModel response = await HTTPGET(
      RoutingCartSuggestion.GET_UserGroupsRecivedSuggestion,
      queries,
      cartSuggestionId.toString(),
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return response;
  }

  Future<ResponseModel> getSuggestionSendedUserGroups(
      {required int userGroupId, List<QueryModel> queries = const []}) async {
    ResponseModel response = await HTTPGET(
      RoutingCartSuggestion.GET_SuggestionSendedUserGroups,
      queries,
      userGroupId.toString(),
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return response;
  }

  Future<ResponseModel> getUserGroupsNotSendedSuggestion(
      {required int cartSuggestionId,
      List<QueryModel> queries = const []}) async {
    ResponseModel response = await HTTPGET(
      RoutingCartSuggestion.GET_UserGroupsNotSendedSuggestion,
      queries,
      cartSuggestionId.toString(),
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    return response;
  }

  Future<ResponseModel> getCartSuggestionById(
      {required int cartSuggestionId,
      List<QueryModel> queries = const []}) async {
    ResponseModel response = await HTTPGET(
      RoutingCartSuggestion.ALL_CartSuggestion,
      queries,
      cartSuggestionId.toString(),
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (kDebugMode) {
      log('cart by id: ${response.data}');
    }
    return response;
  }

  Future<ResponseModel> getCartSuggestionCategory() async {
    ResponseModel response = await HTTPGET(
      RoutingCartSuggestion.getCategoryUrl,
      [QueryModel(name: 'vehicleId', value: '10')],
      null,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data =
          CartSuggestionCategoryModel.toList(dynamicList: response.data);
    }
    return response;
  }

  Future<ResponseModel> updateCartSuggestion(
      {required CartSuggestionItemParams listModel,
      List<QueryModel> queries = const []}) async {
    var body = jsonEncode(listModel);
    ResponseModel response = await HTTPPUT(
      RoutingCartSuggestion.updateCartSuggestionBaseUrl,
      queries,
      body,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (Get.isRegistered<OverlaySearchController>()) {
      Get.delete<OverlaySearchController>();
    }
    return response;
  }
}
