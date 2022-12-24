import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCustomSearchBar extends StatelessWidget {
  const NewCustomSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      padding: EdgeInsets.only(right: 10),
      height: 45,
      decoration: BoxDecoration(
        color: CBase().dinawinWhite,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          // *----- search icon
          Icon(
            Icons.search_rounded,
            color: CBase().dinawinDarkGrey.withOpacity(0.25),
          ),
          SizedBox(width: 5),

          // *----- textfield
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'جستجو'.tr,
                hintStyle: TextStyle(
                  color: CBase().dinawinDarkGrey.withOpacity(0.25),
                ),
              ),
            ),
          ),

          // *----- recorder
          SizedBox(
            height: 30,
            child: VerticalDivider(
              color: CBase().dinawinDarkGrey.withOpacity(0.25),
              thickness: 1,
              width: 0,
            ),
          ),
          SizedBox(
            height: 45,
            width: 45,
            child: Icon(
              Icons.mic_rounded,
              color: CBase().dinawinDarkGrey,
            ),
          )
        ],
      ),
    );
  }
}
