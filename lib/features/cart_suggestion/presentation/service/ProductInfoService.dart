
import 'dart:convert';

import 'package:cart_suggestion_core/core/model/Api.dart';
import 'package:cart_suggestion_core/core/model/enum.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/core/values/Routing/RoutingProductInfo.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/limitation_model.dart';

class ProductInfoService extends Api {
  double totalScore = 0;

  Future<double> getTotalScore() async {
    var response = await HTTPGET(
      RoutingProductInfo.GET_TotalScore,
      [],
      null,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      totalScore = response.data;
    }
    return totalScore;
  }
  Future<ResponseModel> editProductLimitations(
      {required List<Limitation> limitations }) async {
    var body = jsonEncode(limitations);
    ResponseModel response = await HTTPPOST(
      RoutingProductInfo.POST_EditProductLimitations,
      [],
      body,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    return response;
  }

}
