import 'dart:convert';

import 'package:cart_suggestion_core/core/model/Api.dart';
import 'package:cart_suggestion_core/core/model/enum.dart';
import 'package:cart_suggestion_core/core/model/query_model.dart';
import 'package:cart_suggestion_core/core/model/response_model.dart';
import 'package:cart_suggestion_core/core/values/Routing/RoutingGetUser.dart';
import 'package:cart_suggestion_core/core/values/Routing/RoutingUserGroup.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/customer_group_data.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/get_user_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/make_customer_group.dart';


class GetUserService extends Api {
  //
  //*----- get user
  Future<ResponseModel> getUsers({
    int? profileType,
    String? name,
    int? page,
    int? size,
  }) async {
    List<QueryModel> queries = [];
    if (profileType != null) {
      queries
          .add(QueryModel(name: 'profileType', value: profileType.toString()));
    }
    if (name != null) {
      queries.add(QueryModel(name: 'name', value: name));
    }

    queries.add(QueryModel(name: 'page', value: (page ?? 1).toString()));

    queries.add(QueryModel(name: 'size', value: (size ?? 20).toString()));

    ResponseModel response = await HTTPGET(
      RoutingGetUsers.GET_GetUsers,
      queries,
      null,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = GetUserModel.fromJson(response.data);
    }
    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  getCustomerGroups({
    String? name,
    int? page,
    int? size,
  }) async {
    List<QueryModel> queries = [];
    if (name != null) {
      queries.add(QueryModel(name: 'name', value: name));
    }

    queries.add(QueryModel(name: 'page', value: (page ?? 1).toString()));

    queries.add(QueryModel(name: 'size', value: (size ?? 100).toString()));

    ResponseModel response = await HTTPGET(
      RoutingUserGroup.GET_GetUserGroups,
      queries,
      null,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = CustomerGroupData.fromJson(response.data);
    }
    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  getUsersOfGroup({
    required int groupId,
  }) async {
    ResponseModel response = await HTTPGET(
      RoutingUserGroup.GET_GetUserGroups + '/$groupId',
      [],
      null,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    if (response.isSuccess) {
      response.data = CustomerGroup.fromJson(response.data);
    }
    return ResponseModel(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      data: response.data,
      message: response.message,
    );
  }

  Future<ResponseModel> createUserGroup(
      MakeCustomerGroup makeCustomerGroup) async {
    var body = jsonEncode(makeCustomerGroup.toJson());
    ResponseModel response = await HTTPPOST(
      RoutingUserGroup.GET_GetUserGroups,
      [],
      body,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    // if (response.isSuccess) {
    //   response.data = GetUserModel.fromJson(response.data);
    // }
    return response;
  }

  Future<ResponseModel> disableUserGroup({required int userGroupId}) async {
    ResponseModel response = await HTTPPUT(
      RoutingUserGroup.PUT_DisableUserGroups + '/$userGroupId',
      [],
      null,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    // if (response.isSuccess) {
    //   response.data = GetUserModel.fromJson(response.data);
    // }
    return response;
  }

  Future<ResponseModel> removeUserGroupItem({required int userItemId}) async {
    ResponseModel response = await HTTPPUT(
      RoutingUserGroup.PUT_RemoveUserGroupItem + '/$userItemId',
      [],
      null,
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    return response;
  }

  Future<ResponseModel> addUserGroupItem({required List<Map> data}) async {
    ResponseModel response = await HTTPPOST(
      RoutingUserGroup.POST_AddUserGroupItem,
      [],
      jsonEncode(data),
      HeaderEnum.BearerHeaderEnum,
      ResponseEnum.ResponseModelEnum,
    );
    return response;
  }
}
