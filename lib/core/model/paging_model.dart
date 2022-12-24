class PagingModel<T> {
  PagingModel({
    required this.size,
    required this.page,
    required this.totalCount,
    required this.totalPage,
  });
  late final int size;
  late final int page;
  late final int totalCount;
  late final int totalPage;

  PagingModel.fromJson(Map<String, dynamic> json) {
    size = json['size'] ?? 0;
    page = json['page'] ?? 0;
    totalCount = json['totalCount'] ?? 0;
    totalPage = json['totalPage'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['size'] = size;
    data['page'] = page;
    data['totalCount'] = totalCount;
    data['totalPage'] = totalPage;
    return data;
  }
}
