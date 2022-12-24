import 'dart:async';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/widgets/SearchSpeech.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'search_controller.dart';

class DropDownSearch extends StatelessWidget {
  Function(String) onSearch;
  FocusNode? focusNode;
  DropDownSearch({Key? key, required this.onSearch, required this.controller,this.focusNode})
      : super(key: key);

  Timer? timer;
  SimpleSearchController searchController = Get.put(SimpleSearchController());
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: CBase().getFullHeight(context) / 15,
      decoration: BoxDecoration(
        color: CBase().dinawinDarkGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        children: [
          //*----- textfield search
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'سرچ'.tr,
                  hintStyle: TextStyle(
                    color: CBase().dinawinDarkGrey.withOpacity(0.25),
                    fontSize: 14,
                  ),
                  icon: Icon(
                    CupertinoIcons.search,
                    color: CBase().dinawinDarkGrey.withOpacity(0.25),
                  )),
              style: TextStyle(
                fontSize: 14,
                color: CBase().dinawinDarkGrey,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              onChanged: (value) {
                searchController.update(['clear']);
                if (timer != null) timer!.cancel();
                timer = Timer(
                  Duration(milliseconds: 700),
                  () {
                    onSearch(value);
                  },
                );
              },
            ),
          ),
          GetBuilder<SimpleSearchController>(
              id: 'clear',
              builder: (logic) {
                return Visibility(
                  visible: controller.text.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: InkWell(
                        onTap: () {
                          controller.text = '';
                          searchController.clearText();
                          onSearch(controller.text);
                        },
                        child: Icon(Icons.clear)),
                  ),
                );
              }),
          Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0),
            child: VerticalDivider(
              color: CBase().dinawinDarkGrey.withOpacity(0.5),
              width: 0.5,
              thickness: 0.5,
            ),
          ),
          SearchSpeech(
            speechTextCallBack: (result) {
              controller.text = result;
              onSearch(controller.text);
              // controller.text = result;
              // if (timer != null) timer!.cancel();
              // _search();
              // searchController.update(['clear']);
            },
          ),
        ],
      ),
    );
  }
}
