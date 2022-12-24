
class Product {
  String? productsName;
  String? unitsName;
  String? country;
  String? lastMarketPriceUpdate;
  String? brandsImagePath;
  String? brandsName;
  double? productInfosPrice;
  int? productVirtualQTY;
  int? multipleQTY;
  double? score;
  int? productsId;
  int? detailQTY;
  int? supplierId;
  double? lastMarketPrice;
  double? lastSalePrice;
  List<String> images = [];
  bool? warranty;

  Product(
      {this.productsId,
      this.productsName,
      this.unitsName,
      this.brandsImagePath,
      this.productInfosPrice,
      this.productVirtualQTY,
      this.brandsName,
      this.country,
      this.multipleQTY,
      this.score,
      this.lastMarketPrice,
      this.images = const [],
      this.warranty,
      this.lastSalePrice,
      this.detailQTY,
      this.supplierId,
      this.lastMarketPriceUpdate});

  Product.fromJson(Map<String, dynamic> json) {
    productsId = json['productsId'] ?? 0;
    productsName = json['productsName'] ?? "نام وارد نشده";
    unitsName = json['unitsName'] ?? "";
    brandsName = json['brandsName'] ?? "نام وارد نشده";
    brandsImagePath = json['brandsImagePath'] ?? "";
    productInfosPrice = json['productInfosPrice'] ?? 0;
    productVirtualQTY = json['productVirtualQTY'] ?? json['totalQTY'] ?? 1;
    detailQTY = json['detailQTY'] ?? 0;
    supplierId = json['supplierId'] ?? 0;
    //change this later when the model is unique.
    if (json['country'] == null || json['country'].runtimeType == String)
      country = json['country'] ?? "";
    else
      country = json['country']["name"] ?? "";
    multipleQTY = json['multipleQTY'] ?? 1;
    if (multipleQTY! <= 0) {
      multipleQTY = 1;
    }
    score = json['mechanicScore'] ?? 0;
    lastMarketPrice = json['lastMarketPrice'] ?? 0;
    lastSalePrice = json['lastSalePrice'] ?? 0;
    //change this later when the model is unique
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        if (v.runtimeType == String)
          images.add(v);
        else if (v != null) images.add(ProductImage.fromJson(v).path!);
      });
      images = images.toSet().toList();
    }

    warranty = json["warranty"] ?? false;
    lastMarketPriceUpdate = json['lastMarketPriceUpdate'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productsId'] = this.productsId;
    data['productsName'] = this.productsName;
    data['unitsName'] = this.unitsName;
    data['brandsName'] = this.brandsName;
    data['brandsImagePath'] = this.brandsImagePath;
    data['productInfosPrice'] = this.productInfosPrice;
    data['productVirtualQTY'] = this.productVirtualQTY;
    data['country'] = this.country;
    data['multipleQTY'] = this.multipleQTY;
    data['mechanicScore'] = this.score;
    data['lastMarketPrice'] = this.lastMarketPrice;
    data['lastSalePrice'] = this.lastSalePrice;
    data['detailQTY'] = this.detailQTY;
    data['supplierId'] = this.supplierId;

    data['images'] = this.images.map((v) => v).toList();

    data['warranty'] = this.warranty;
    data['lastMarketPriceUpdate'] = this.lastMarketPriceUpdate;
    return data;
  }


  bool isForSale() {
    return this.productVirtualQTY != null &&
        this.productVirtualQTY! > 0 &&
        this.productVirtualQTY! >= this.multipleQTY!;
  }
}
class ProductImage {
  String? path;
  String? type;
  int? id;


  ProductImage({this.path, this.type , this.id});

  ProductImage.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }
}