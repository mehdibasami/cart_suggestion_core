import 'package:cart_suggestion_core/features/cart_suggestion/data/model/get_user_value_model.dart';

class GetUserModel {
  int? size;
  int? page;
  int? totalCount;
  int? totalPage;
  List<GetUserValueModel>? getUserValueModel;

  GetUserModel({
    this.size,
    this.page,
    this.totalCount,
    this.totalPage,
    this.getUserValueModel,
  });

  //*----- from json
  GetUserModel.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    page = json['page'];
    totalCount = json['totalCount'];
    totalPage = json['totalPage'];
    if (json['values'] != null) {
      getUserValueModel = <GetUserValueModel>[];
      json['values'].forEach((v) {
        getUserValueModel!.add(new GetUserValueModel.fromJson(v));
      });
    }
  }

  //*----- to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['size'] = this.size;
    data['page'] = this.page;
    data['totalCount'] = this.totalCount;
    data['totalPage'] = this.totalPage;
    if (this.getUserValueModel != null) {
      data['values'] = this.getUserValueModel;
    }
    return data;
  }

  //*----- list from json
  List<GetUserModel>? listFromJson(dynamic json) {
    if (json != null) {
      return json.map<GetUserModel>((j) {
        return GetUserModel.fromJson(j);
      }).toList();
    }
    return null;
  }
}
