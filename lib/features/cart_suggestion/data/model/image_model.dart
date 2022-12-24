class ImageModel {
  late final int id;
  late final String path;
  late final String fileType;

  ImageModel({
    this.id = 0,
    this.path = '',
    this.fileType = '',
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    path = json['path'];
    fileType = json['fileType'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['path'] = path;
    _data['fileType'] = fileType;
    return _data;
  }

  List<ImageModel> listFromJson(List<dynamic>? json) {
    if (json != null) {
      return json.map<ImageModel>((j) {
        return ImageModel.fromJson(j);
      }).toList();
    }
    return [];
  }
}
