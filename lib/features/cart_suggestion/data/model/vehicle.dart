class Vehicle {
  String? name;
  String? imagePath;
  String? persianName;
  int? id;

  Vehicle({
    this.name,
    this.imagePath,
    this.persianName,
    this.id,
  });

  Vehicle.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    imagePath = json['imagePath'] ?? "";
    persianName = json['persianName'] ?? "";
    id = json['id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data ={};
    data['name'] = name;
    data['imagePath'] = imagePath;
    data['persianName'] = persianName;
    data['id'] = id;
    return data;
  }

  List<Vehicle>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Vehicle>((ct) {
        return Vehicle.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
