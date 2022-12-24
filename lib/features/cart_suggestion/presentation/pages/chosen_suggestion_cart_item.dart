import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/overlay_search_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/cart_suggestion_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ChosenSuggestionCartItem extends StatefulWidget {
  ChosenSuggestionCartItem({Key? key, required this.makeList})
      : super(key: key);
  final CartSuggestionItemParams makeList;

  @override
  State<ChosenSuggestionCartItem> createState() =>
      _ChosenSuggestionCartItemState();
}

class _ChosenSuggestionCartItemState extends State<ChosenSuggestionCartItem> {
  OverlaySearchController _overlaySearchController =
      Get.put(OverlaySearchController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<OverlaySearchController>(
          id: 'remove_item',
          builder: (_) {
            return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: widget.makeList.details.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartSuggestionItem(
                    detailModel: widget.makeList.details[index],
                    onTapCloseIcon: () {
                      var item = widget.makeList.details[index];
                      widget.makeList.details.removeAt(index);
                      _overlaySearchController.deleteItem(item);
                    },
                  ).marginSymmetric(vertical: 8);
                });
          }),
    );
  }

  mainText(String text) => Text(
        text,
        maxLines: 2,
        style: TextStyle(
          fontSize: CBase().dinawinWidth(context) / 35,
          color: CBase().dinawinDarkGrey,
          fontWeight: FontWeight.bold,
        ),
      );

  switchBtn({
    required MainAxisAlignment alignment,
    required Function onTap,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: CBase().dinawinWidth(context) / 12,
        height: CBase().dinawinWidth(context) / 12,
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: alignment,
          children: [
            Container(
              width: CBase().dinawinWidth(context) / 12,
              height: CBase().dinawinWidth(context) / 12,
              decoration: BoxDecoration(
                color:
                    isSelected ? CBase().dinawinDarkGrey : CBase().dinawinWhite,
                borderRadius: BorderRadius.circular(5),
                border: isSelected
                    ? null
                    : Border.all(color: CBase().dinawinDarkGrey, width: 1),
              ),
              child: Center(
                child: Icon(
                  isSelected ? Icons.check : Icons.add,
                  color: isSelected
                      ? CBase().dinawinWhite
                      : CBase().dinawinDarkGrey,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// CartSuggestionItem(
//                     detailModel: widget.makeList.details[index],
//                     onTapCloseIcon: () {
//                       var item = widget.makeList.details[index];
//                       widget.makeList.details.removeAt(index);
//                       _overlaySearchController.deleteItem(item);
//                     },
//                   )