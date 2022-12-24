// import 'package:cart_suggestion_core/cart_suggestion_core.dart';
// import 'package:copapp/Controller/Controllers/cart_suggestion/overlay_search_controller.dart';
// import 'package:copapp/Model/cart_suggestion/part_with_detail_product_model.dart';
// import 'package:copapp/Utilities/Base.dart';
// import 'package:copapp/View/Pages/cart_suggestion/widget/cart_description_item.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ChosenProductItem extends StatefulWidget {
//   final CartSuggestionDetailModel product;
//   final CartSuggestionItemParams makeListModel;

//   ChosenProductItem({
//     Key? key,
//     required this.product,
//     required this.makeListModel,
//   }) : super(key: key);

//   @override
//   State<ChosenProductItem> createState() => _ChosenProductItemState();
// }

// class _ChosenProductItemState extends State<ChosenProductItem> {
//   @override
//   initState() {
//     super.initState();
//     _checkList();
//     // _setSelected();
//   }

//   // int itemCount = 0;
//   // bool isSelected = false;
//   OverlaySearchController controller = Get.put(OverlaySearchController());
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<OverlaySearchController>(
//         id: 'remove_item',
//         builder: (_) {
//           return Container(
//             margin: EdgeInsets.symmetric(horizontal: 30),
//             padding: EdgeInsets.fromLTRB(5, 15, 15, 15),
//             decoration: BoxDecoration(
//               color: CBase().dinawinWhite,
//               borderRadius: BorderRadius.circular(5),
//             ),
//             child: Container(
//               // color: Colors.blue,
//               height: CBase().dinawinWidth(context) / 3,
//               child: Row(
//                 children: [
//                   // *----- description
//                   Expanded(
//                       child: CartItemDescription(
//                     switchBtn: switchBtn(
//                       alignment: MainAxisAlignment.end,
//                       isSelected: (widget.makeListModel.details
//                                   .firstWhereOrNull((element) =>
//                                       element.productId ==
//                                       (widget.product.productId ?? -1))
//                                   ?.suggestQty ??
//                               0) >
//                           0,
//                       onTap: () {
//                         setState(() {
//                           onUpdate(
//                             CartSuggestionDetailModel(
//                               virtualQty: widget.product.virtualQty,
//                               productId: widget.product.productId,
//                               suggestQty: widget.product.suggestQty ?? 1,
//                               productName: widget.product.productName,
//                               country: widget.product.country,
//                               productImage: widget.product.productImage,
//                               cashPrice: widget.product.cashPrice ?? 0,
//                               creditPrice: widget.product.creditPrice ?? 0,
//                               brandImage: widget.product.brandImage,
//                               multipleQty: widget.product.multipleQty,
//                               brandName: widget.product.brandName,
//                               // vehicles:
//                             ),
//                             (widget.makeListModel.details
//                                         .firstWhereOrNull((element) =>
//                                             element.productId ==
//                                             (widget.product.productId ?? -1))
//                                         ?.suggestQty ??
//                                     0) >
//                                 0,
//                           );
//                         });
//                       },
//                     ),
//                     productVirtualQTY: widget.product.virtualQty ?? 0,
//                     productName: widget.product.productName ?? 'نام محصول',
//                     cashPrice: widget.product.cashPrice!.toInt().toString(),
//                     creditPrice: widget.product.creditPrice == null
//                         ? '0'
//                         : widget.product.creditPrice!.toInt().toString(),
//                     brandName: widget.product.brandName ?? 'برند',
//                     countryName: widget.product.country ?? 'کشور',
//                     vehicle: widget.product.vehicles ?? '',
//                   )),

//                   const VerticalDivider(),

// // *----- product img
//                   // Container(
//                   //   width: CBase().dinawinWidth(context) / 4,
//                   //   decoration: BoxDecoration(
//                   //     borderRadius: BorderRadius.circular(5),
//                   //     image: widget.product.images!.isNotEmpty
//                   //         ? DecorationImage(
//                   //             image: NetworkImage(widget.product.images!.first))
//                   //         : DecorationImage(
//                   //             image: AssetImage('images/noimageiconsmall.png'),
//                   //           ),
//                   //   ),
//                   // ),
//                   // *----- item number
//                   // Container(
//                   //   width: 48,
//                   //   child: Column(
//                   //     mainAxisAlignment: MainAxisAlignment.end,
//                   //     children: [
//                   //       // //*--- add btn
//                   //       // addSubBtn(
//                   //       //   alignment: MainAxisAlignment.start,
//                   //       //   icon: Icons.add_rounded,
//                   //       //   onTap: () {
//                   //       //     setState(() {
//                   //       //       itemCount += widget.product.multipleQTY ?? 1;
//                   //       //     });
//                   //       //     onUpdate(CartSuggestProduct(
//                   //       //         productId: widget.product.productsId,
//                   //       //         suggestQty: itemCount));
//                   //       //   },
//                   //       // ),
//                   //       // Text(itemCount.toString()),

//                   //       // //*--- sub btn
//                   //       // addSubBtn(
//                   //       //   alignment: MainAxisAlignment.end,
//                   //       //   icon: Icons.remove_rounded,
//                   //       //   onTap: () {
//                   //       //     setState(() {
//                   //       //       if (itemCount >= 1) {
//                   //       //         itemCount -= widget.product.multipleQTY ?? 1;
//                   //       //         onUpdate(CartSuggestProduct(
//                   //       //             productId: widget.product.productsId,
//                   //       //             suggestQty: itemCount));
//                   //       //       }
//                   //       //     });
//                   //       //   },
//                   //       // ),

//                   //     ],
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   Text productModel(String text) => Text(
//         text,
//         style: TextStyle(
//           color: CBase().dinawinDarkGrey,
//           fontSize: 12,
//         ),
//       );

//   addSubBtn({
//     required MainAxisAlignment alignment,
//     required IconData icon,
//     required Function onTap,
//   }) {
//     return InkWell(
//       onTap: () {
//         onTap();
//       },
//       child: Container(
//         width: CBase().dinawinWidth(context) / 12,
//         height: CBase().dinawinWidth(context) / 12,
//         // color: Colors.red,
//         child: Column(
//           mainAxisAlignment: alignment,
//           children: [
//             Container(
//               width: CBase().dinawinWidth(context) / 12,
//               height: CBase().dinawinWidth(context) / 12,
//               decoration: BoxDecoration(
//                 color: CBase().dinawinDarkGrey,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Center(
//                 child: Icon(
//                   icon,
//                   color: CBase().dinawinWhite,
//                   size: 20,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   switchBtn({
//     required MainAxisAlignment alignment,
//     required Function onTap,
//     required bool isSelected,
//   }) {
//     return InkWell(
//       onTap: () {
//         onTap();
//       },
//       child: Container(
//         width: CBase().dinawinWidth(context) / 12,
//         height: CBase().dinawinWidth(context) / 12,
//         // color: Colors.red,
//         child: Column(
//           mainAxisAlignment: alignment,
//           children: [
//             Container(
//               width: CBase().dinawinWidth(context) / 12,
//               height: CBase().dinawinWidth(context) / 12,
//               decoration: BoxDecoration(
//                 color: isSelected ? CBase().dinawinBrown : CBase().dinawinWhite,
//                 borderRadius: BorderRadius.circular(5),
//                 border: isSelected
//                     ? null
//                     : Border.all(color: CBase().dinawinBrown, width: 1),
//               ),
//               child: Center(
//                 child: Icon(
//                   isSelected ? Icons.check : Icons.add,
//                   color:
//                       isSelected ? CBase().dinawinWhite : CBase().dinawinBrown,
//                   size: 20,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _checkList() {
//     widget.makeListModel.details = [];
//   }

//   void onUpdate(CartSuggestionDetailModel p, bool isSelected) {
//     print((widget.makeListModel.details
//             .firstWhereOrNull((element) =>
//                 element.productId == (widget.product.productId ?? -1))
//             ?.suggestQty ??
//         0));
//     if (isSelected) {
//       /// remove item from list
//       _remove(p);
//     } else {
//       /// item doesn't exist in the list
//       _add(p);
//     }
//   }

//   // void onUpdate(CartSuggestProduct p) {
//   //   if (p.suggestQty == 0) {
//   //     /// remove item from list
//   //     _remove(p);
//   //   } else if (widget.makeListModel.chosenProduct
//   //           ?.any((element) => element.productId == (p.productId ?? -1)) ??
//   //       false) {
//   //     /// item already exists and should update count
//   //     _update(p);
//   //   } else {
//   //     /// item count is not zero and it doesn't exist in the list
//   //     _add(p);
//   //   }
//   // }

//   // void _update(CartSuggestProduct p) {
//   //   var item = widget.makeListModel.chosenProduct
//   //       ?.firstWhere((element) => element.productId == p.productId);
//   //   if (item != null) {
//   //     item.suggestQty = p.suggestQty;
//   //   }
//   // }

//   void _add(CartSuggestionDetailModel p) {
//     widget.makeListModel.details.add(p);
//   }

//   void _remove(CartSuggestionDetailModel p) {
//     widget.makeListModel.details
//         .removeWhere((element) => element.productId == p.productId);
//   }

//   // void _setSelected() {
//   //   var item = widget.makeListModel.chosenProduct?.firstWhereOrNull(
//   //       (element) => element.productId == (widget.product.productsId ?? -1));
//   //   if (item != null) {
//   //     setState(() {
//   //       isSelected = (item.suggestQty ?? 0) > 0;
//   //     });
//   //   }
//   // }

// // void _setCount() {
// //   var item = widget.makeListModel.chosenProduct?.firstWhereOrNull(
// //       (element) => element.productId == (widget.product.productsId ?? -1));
// //   if (item != null) {
// //     setState(() {
// //       itemCount = item.suggestQty ?? 0;
// //     });
// //   }
// // }
// }
