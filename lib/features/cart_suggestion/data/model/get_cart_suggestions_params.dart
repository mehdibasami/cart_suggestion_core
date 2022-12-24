class GetCartSuggestionParams {
  int cartId;
  int? brandId;
  List<int>? appId;
  List<int> sortAppId;

  GetCartSuggestionParams({
    required this.cartId,
    this.brandId,
    this.appId,
    this.sortAppId = const [],
  });
}
