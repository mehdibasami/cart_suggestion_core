class GetUserValueModel {
  int? id;
  String? fullName;
  String? userName;
  String? email;
  String? phoneNumber;
  int? type;
  String? typeName;

  GetUserValueModel({
    this.id,
    this.fullName,
    this.userName,
    this.email,
    this.phoneNumber,
    this.type,
    this.typeName,
  });

  //*----- from json
  GetUserValueModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    type = json['type'];
    typeName = json['typeName'];
  }

  //*----- to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['type'] = this.type;
    data['typeName'] = this.typeName;
    return data;
  }

  //*----- list from json
  List<GetUserValueModel>? listFromJson(dynamic json) {
    if (json != null) {
      return json.map<GetUserValueModel>((j) {
        return GetUserValueModel.fromJson(j);
      }).toList();
    }
    return null;
  }
}
