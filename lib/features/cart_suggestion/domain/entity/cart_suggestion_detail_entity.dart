import 'package:cart_suggestion_core/features/cart_suggestion/data/model/cart_suggestion_detail_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/limitation_model.dart';

class CartSuggestionDetailEntity {
  int? id;
  int? productId;
  String productCode;
  int? suggestQty;
  String? productName;
  int? showPriceApp;
  String showTextApp;
  String? brandName;
  String? productImage;
  FileType? fileType;
  String? brandImage;
  String? country;
  String? partNumber;
  int? price;
  int? virtualQty;
  int realQty;
  int physicalQty;
  int totalQty;
  int paymentWay;
  String? vehicles;
  int? multipleQty;
  int? qty;
  int? cashPrice;
  int? creditPrice;
  bool isContainBundle;
  bool isCreditSaleActive;
  bool isCashSaleActive;
  List<Limitation> limitations;
  bool isGift;
  bool isProductGarrantied;
  Bundle? bundle;
  List<BundlePrices> bundlePrices;
  int paymentCreditDeadlineDay;
  CartSuggestionDetailEntity({
    this.id,
    this.productId,
    this.productCode='',
    this.suggestQty,
    this.showPriceApp = 0,
    this.qty = 0,
    this.showTextApp = '',
    this.productName,
    this.brandName,
    this.productImage,
    this.fileType, 
    this.brandImage,
    this.country,
    this.partNumber,
    this.price,
    this.virtualQty,
    this.vehicles,
    this.multipleQty,
    this.cashPrice,
    this.creditPrice,
    this.isCreditSaleActive = false,
    this.isCashSaleActive = false,
    this.isContainBundle = false,
    this.isGift = false,
    this.isProductGarrantied = false,
    this.bundle,
    this.bundlePrices = const     [],
    this.limitations =const [],
    this.realQty = 0,
    this.totalQty=0,
    this.physicalQty=0,
    this.paymentCreditDeadlineDay = 0,
    this.paymentWay = 2,
  });
}
