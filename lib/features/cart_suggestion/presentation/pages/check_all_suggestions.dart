import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/chosen_suggestion_cart_item.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/custom_add_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/custom_dark_btn.dart';
import '../widget/second_app_bar.dart';
import '../widget/select_purchase_type_modal.dart';

class CheckAllSuggestion extends StatefulWidget {
  CheckAllSuggestion({Key? key, required this.makeListModel}) : super(key: key);
  final CartSuggestionItemParams makeListModel;

  @override
  State<CheckAllSuggestion> createState() => _CheckAllSuggestionState();
}

class _CheckAllSuggestionState extends State<CheckAllSuggestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondAppBar(
        title: 'بررسی سبد'.tr,
        // onWillPop: () {
        //   Navigator.pop(context);
        // }
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
            child: Row(
              children: [
                Text(
                  'افزودن کالا',
                  style: TextStyle(
                    color: CBase().dinawinDarkGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                CustomAddButton(
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
          ChosenSuggestionCartItem(
            makeList: widget.makeListModel,
          ),
          CustomDarkBtn(
            ontap: () {
              if (widget.makeListModel.details.isNotEmpty) {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SelectPurchaseTypeModal(
                    makeListModel: widget.makeListModel,
                  ),
                );
              } else {
                Snacki().GETSnackBar(
                  false,
                  'هیچ کالایی انتخاب نشده است.',
                );
              }
            },
            title: 'ثبت',
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
