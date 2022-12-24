class Limitation {
  Limitation({
    required this.productId,
    required this.profileTypeId,
    required this.profileTypeName,
    required this.day,
    required this.qty,
    required this.displayName,
  });
   int productId=0;
   ProfileTypeId profileTypeId=ProfileTypeId.none;
   String profileTypeName='';
   int day=0;
   int qty=0;
   String displayName='';

  Limitation.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    profileTypeId = ProfileTypeId
        .values[json['profileTypeId'] > 7 ? 0 : json['profileTypeId']];

    profileTypeName = json['profileTypeName'];
    day = json['day'];
    qty = json['qty'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['productId'] = productId;
    data['profileTypeId'] = profileTypeId.index;
    data['profileTypeName'] = profileTypeName;
    data['day'] = day;
    data['qty'] = qty;
    data['displayName'] = displayName;
    return data;
  }
}

enum ProfileTypeId {
  none,
  endUser,
  system,
  unknown,
  sale,
  support,
  warehouse,
  coWorker,
}
// extension MyEnumExtension on ProfileTypeId {
//   int get id {
//     switch (this) {
//       case ProfileTypeId.coWorker:
//         return 7;
//       default:
//         return -1;
//     }
//   }
// }