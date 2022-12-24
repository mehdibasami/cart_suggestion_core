class CustomerGroupData {
  int? size;
  int? page;
  int? totalCount;
  int? totalPage;
  List<CustomerGroup>? customerGroups;

  CustomerGroupData(
      {this.size,
      this.page,
      this.totalCount,
      this.totalPage,
      this.customerGroups});

  CustomerGroupData.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    page = json['page'];
    totalCount = json['totalCount'];
    totalPage = json['totalPage'];
    if (json['values'] != null) {
      customerGroups = <CustomerGroup>[];
      json['values'].forEach((v) {
        customerGroups!.add(new CustomerGroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['page'] = this.page;
    data['totalCount'] = this.totalCount;
    data['totalPage'] = this.totalPage;
    if (this.customerGroups != null) {
      data['values'] = this.customerGroups!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerGroup {
  int? id;
  String? title;
  List<CustomerModel>? items;

  CustomerGroup({this.id, this.title, this.items});

  CustomerGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['items'] != null) {
      items = <CustomerModel>[];
      json['items'].forEach((v) {
        items!.add(new CustomerModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerModel {
  int? id;
  int? userId;
  String? phoneNumber;
  String? fullName;

  CustomerModel({this.userId, this.phoneNumber, this.fullName});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['phoneNumber'] = this.phoneNumber;
    data['fullName'] = this.fullName;
    return data;
  }
}
