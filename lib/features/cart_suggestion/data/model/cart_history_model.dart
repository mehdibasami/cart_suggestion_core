class CartHistoryModel {
  int? userGroupId;
  int? suggestionId;
  String? suggestionName;
  String? userGroupName;
  DateTime? sendedDateTime;

  CartHistoryModel({
    this.userGroupId,
    this.suggestionId,
    this.suggestionName,
    this.userGroupName,
    this.sendedDateTime,
  });

  //*----- from json
  CartHistoryModel.fromJson(Map<String, dynamic> json) {
    userGroupId = json['userGroupId'];
    suggestionId = json['suggestionId'];
    suggestionName = json['suggestionName'];
    userGroupName = json['userGroupName'];
    sendedDateTime = json['sendedDateTime'] != null
        ? DateTime.parse(json['sendedDateTime'])
        : null;
  }

  //*----- to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userGroupId'] = this.userGroupId;
    // data['suggestionId'] = this.suggestionId;
    // data['suggestionName'] = this.suggestionName;
    data['userGroupName'] = this.userGroupName;
    data['sendedDateTime'] =
        sendedDateTime != null ? sendedDateTime!.toIso8601String() : null;

    return data;
  }

  //*----- list from json
  List<CartHistoryModel>? listFromJson(dynamic json) {
    if (json != null) {
      return json.map<CartHistoryModel>((j) {
        return CartHistoryModel.fromJson(j);
      }).toList();
    }
    return null;
  }
}
