import 'dart:convert';
import 'dart:developer';

import 'package:cart_suggestion_core/core/model/enum.dart';
import 'package:cart_suggestion_core/core/model/query_model.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/core/model/Api.dart';
import 'package:cart_suggestion_core/core/values/Routing/RoutingBalance.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/SearchPart.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/part.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/part_with_detail_model.dart';
import 'package:flutter/foundation.dart';

class BalanceServiceV2  extends Api {

  bool? sortBool;


  Future<ResponseModel> quickSearch(
      {required String search,
      required List<int> vehicleIds,
      required List<int> brandIds}) async {
    Map<String, dynamic> map = {};
    map = {
      "search": search,
      "vehicleIds": vehicleIds,
      'brandIds': brandIds,
      "keywordId": []
    };
    ResponseModel response = await HTTPPOST(
      // RoutingBalance.POST_GetBalanceQuickSearchV2,
      RoutingBalance.POST_SearchParts,
      [
        // QueryModel(name: "search", value: search),
        // QueryModel(name: "keywordId", value: keywordId.toString())
      ],
      jsonEncode(map),
      // HeaderEnum.BearerHeaderEnum,
      HeaderEnum.BasicHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );

    if (response.isSuccess) {
      response.data = SearchPart().listFromJson(response.data);
    }
    return response;
  }
  Future<ResponseModel> getSelectedBalanceData(
      int? categoryId, List<String> parts, int? vehicle, int? filter) async {
    Map<String, dynamic> json;
    if (categoryId == null || vehicle == null) {
      json = {
        "parts": parts,
      };
    } else {
      json = {
        // "categoryId": categoryId,
        "parts": parts,
        "vehicles": [vehicle],
        "filter": filter,
      };
    }
    var body = jsonEncode(json);
    ResponseModel response = await HTTPPOST(
      RoutingBalance.Post_GetSelectedBalanceData,
      [],
      body,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = Part().listFromJson(response.data);
    }
    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  
  Future<ResponseModel> getSuggestionData(
      {required List<String> parts,
      required List<int> brands,
      required List<int> vehicles}) async {
    Map<String, dynamic> json;

    json = {
      "parts": parts,
      "vehicles": vehicles,
      "brands": brands,
    };

    var body = jsonEncode(json);
    ResponseModel response = await HTTPPOST(
      RoutingBalance.Post_GetPartsWithDetails,
      [QueryModel(name: 'withBundle', value: 'true')],
      body,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (kDebugMode) {
      log('data get with part: ${response.data}');
    }
    if (response.isSuccess) {
      response.data = PartWithDetailModel().listFromJson(response.data);
    }
    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

}
