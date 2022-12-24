import 'package:cart_suggestion_core/features/cart_suggestion/data/model/limitation_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/domain/entity/cart_suggestion_detail_entity.dart';

class CartSuggestionDetailModel extends CartSuggestionDetailEntity {
  CartSuggestionDetailModel({
    int? id,
    String productCode = '',
    int? productId,
    int? suggestQty,
    int? price,
    int? virtualQty,
    int totalQty = 0,
    int physicalQty = 0,
    int? multipleQty,
    int? cashPrice,
    int? creditPrice,
    int? paymentWay,
    int? realQty,
    int paymentCreditDeadlineDay = 0,
    int qty = 0,
    String? productName,
    String? brandName,
    String? productImage,
    FileType? fileType,
    String? brandImage,
    String? country,
    String? partNumber,
    String? vehicles,
    String showTextApp = '',
    int showPriceApp = 0,
    Bundle? bundle,
    List<BundlePrices> bundlePrices = const [],
    List<Limitation> limitations = const [],
    bool isCreditSaleActive = false,
    bool isCashSaleActive = false,
    bool isContainBundle = false,
    bool isGift = false,
    bool isProductGarrantied = false,
  }) : super(
          id: id,
          bundlePrices: bundlePrices,
          productCode: productCode,
          productId: productId,
          suggestQty: suggestQty,
          productName: productName,
          brandName: brandName,
          productImage: productImage,
          fileType: fileType,
          brandImage: brandImage,
          country: country,
          partNumber: partNumber,
          price: price,
          showPriceApp: showPriceApp,
          showTextApp: showTextApp,
          virtualQty: virtualQty ?? 0,
          qty: qty,
          vehicles: vehicles,
          multipleQty: multipleQty,
          cashPrice: cashPrice,
          creditPrice: creditPrice,
          isCashSaleActive: isCashSaleActive,
          isCreditSaleActive: isCreditSaleActive,
          isContainBundle: isContainBundle,
          isGift: isGift,
          isProductGarrantied: isProductGarrantied,
          limitations: limitations,
          bundle: bundle,
          realQty: realQty ?? 0,
          physicalQty: physicalQty,
          totalQty: totalQty,
          paymentCreditDeadlineDay: paymentCreditDeadlineDay,
          paymentWay: paymentWay ?? 2,
        );

  //*----- from json
  CartSuggestionDetailModel.fromJson(Map<String, dynamic> json) {
    List<String> images = [];
    if (json['images'] != null) {
      images = <String>[];
      json['images'].forEach((v) {
        images.add(v);
      });
    }
    final localVirtQty = json['virtualQty'] ?? json['virtualQTY'];
    final localTotalQty = json['totalQty'] ?? json['totalQTY'];
    final localPhysicalQty = json['physicalQty'] ?? json['physicalQTY'];
    final localMultipleQty = json['multipleQty'] ?? json['multipleQTY'];
    id = json['id'];
    productId = json['productId'] ?? json['productsId'];
    productCode = json['productCode'] ?? '';
    suggestQty = json['suggestQty'];
    productName = json['productName'] ?? json['productsName'];
    brandName = json['brandName'] ?? json['brandsName'];
    productImage =
        json['productImage'] ?? (images.isNotEmpty ? images.first : '');
    // fileType = json['fileType'];
    fileType = FileType.video.name == json['fileType']
        ? FileType.video
        : FileType.image;
    brandImage = json['brandImage'] ?? json['brandsImagePath'];
    country = json['country'];
    isCreditSaleActive = json['isCreditSaleActive'] ?? false;
    isCashSaleActive = json['isCashSaleActive'] ?? false;
    isContainBundle = json['isContainBundle'] ?? false;
    isGift = json['isGift'] ?? false;
    isProductGarrantied = json['isProductGarrantied'] ?? false;
    bundle = json['bundle'] != null ? Bundle.fromJson(json['bundle']) : null;
    partNumber = json['partNumber'];
    price = (json['price'] is double)
        ? (json['price'] as double).toInt()
        : json['price'];
    virtualQty = (localVirtQty is double) ? localVirtQty.toInt() : localVirtQty;
    totalQty =
        (localTotalQty is double) ? localTotalQty.toInt() : localTotalQty ?? 0;
    physicalQty = (localPhysicalQty is double)
        ? localPhysicalQty.toInt()
        : localPhysicalQty ?? 0;
    qty = json['qty'] ?? 0;
    showPriceApp = (json['showPriceApp'] is double)
        ? (json['showPriceApp'] as double).toInt()
        : json['showPriceApp'];
    showTextApp = json['showTextApp'] ?? '';
    paymentCreditDeadlineDay = json['paymentCreditDeadlineDay'] ?? 0;
    vehicles = json['vehicles'];
    if (localMultipleQty == 0) {
      multipleQty = 1;
    } else {
      multipleQty = localMultipleQty ?? json['itemQuantity'];
    }
    cashPrice = (json['cashPrice'] is double)
        ? (json['cashPrice'] as double).toInt()
        : json['cashPrice'];
    creditPrice = (json['creditPrice'] is double)
        ? (json['creditPrice'] as double).toInt()
        : json['creditPrice'];
    bundlePrices = json['bundlePrices'] == null
        ? []
        : List.from(json['bundlePrices'])
            .map((e) => BundlePrices.fromJson(e))
            .toList();
    limitations = json['limitations'] == null
        ? []
        : List.from(json['limitations'])
            .map((e) => Limitation.fromJson(e))
            .toList();
    paymentWay = json['paymentWay'] == 0 ? 2 : json['paymentWay'] ?? 2;

    realQty = json['basketQty'] ?? json['itemQuantity'] ?? 0;
  }

  //*----- to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['productCode'] = productCode;
    data['suggestQty'] = suggestQty;
    data['productName'] = productName;
    data['brandName'] = brandName;
    data['productImage'] = productImage;
    // data['fileType'] = fileType;
    // data['fileType'] = fileType.name;
    data['brandImage'] = brandImage;
    data['showPriceApp'] = showPriceApp;
    data['showTextApp'] = showTextApp;
    data['country'] = country;
    data['partNumber'] = partNumber;
    data['price'] = price;
    data['virtualQty'] = virtualQty;
    data['physicalQty'] = physicalQty;
    data['totalQty'] = totalQty;
    data['vehicles'] = vehicles;
    data['multipleQty'] = multipleQty;
    data['cashPrice'] = cashPrice;
    data['creditPrice'] = creditPrice;
    data['qty'] = qty;
    data['bundlePrices'] = bundlePrices;

    data['bundle'] = bundle;
    data['isCreditSaleActive'] = isCreditSaleActive;
    data['isCashSaleActive'] = isCashSaleActive;
    data['isContainBundle'] = isContainBundle;
    data['isGift'] = isGift;
    data['isProductGarrantied'] = isProductGarrantied;
    data['paymentCreditDeadlineDay'] = paymentCreditDeadlineDay;

    return data;
  }

  //*----- list from json
  List<CartSuggestionDetailModel>? listFromJson(dynamic json) {
    if (json != null) {
      return json.map<CartSuggestionDetailModel>((j) {
        return CartSuggestionDetailModel.fromJson(j);
      }).toList();
    }
    return null;
  }
}

class Bundle {
  Bundle({
    this.bundleId = 0,
    this.title = '',
    this.productId = 0,
    this.items = const [],
    this.bundlePrices = const [],
  });
  int bundleId = 0;
  String title = '';
  int productId = 0;
  List<CartSuggestionDetailModel> items = [];
  List<BundlePrices> bundlePrices = const [];

  Bundle.fromJson(Map<String, dynamic> json) {
    bundlePrices = json['bundlePrices'] == null
        ? []
        : List.from(json['bundlePrices'])
            .map((e) => BundlePrices.fromJson(e))
            .toList();

    bundleId = json['bundleId'] ?? 0;
    title = json['title'] ?? '';
    productId = json['productId'] ?? 0;
    items = List.from(json['items'] ?? [])
        .map((e) => CartSuggestionDetailModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bundleId'] = bundleId;
    data['title'] = title;
    data['productId'] = productId;
    data['bundlePrices'] = bundlePrices;

    data['items'] = items;
    return data;
  }
}

class BundlePrices {
  BundlePrices({
    required this.title,
    required this.credit,
    required this.cash,
  });
  late final String title;
  late final int credit;
  late final int cash;

  BundlePrices.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    credit = (json['credit'] is double)
        ? (json['credit'] as double).toInt()
        : json['credit'] ?? 0;
    cash = (json['cash'] is double)
        ? (json['cash'] as double).toInt()
        : json['cash'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['credit'] = credit;
    data['cash'] = cash;
    return data;
  }
}

enum PaymentWay { none, credit, cash }

enum FileType { image, video }
