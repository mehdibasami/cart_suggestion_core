class MakeCustomerGroup {
  int? id;
  String? title;
  List<int>? userIds;

  MakeCustomerGroup({this.id, this.title, this.userIds});

  MakeCustomerGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    userIds = json['userIds'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['userIds'] = this.userIds;
    return data;
  }
}
