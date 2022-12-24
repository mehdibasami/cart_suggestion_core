import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/values/typography.dart';
import 'package:cart_suggestion_core/core/widgets/custom_select_button.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/limitation_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/edit/limitation_dialog_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/limitation_item_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditLimitationPage extends StatelessWidget {
  EditLimitationPage({Key? key, required this.cartSuggestionDetailEntity})
      : super(key: key);
  final CartSuggestionDetailEntity cartSuggestionDetailEntity;
  final limitationDialogController = Get.put(LimitationDialogController());
  @override
  Widget build(BuildContext context) {
    limitationDialogController.limitations = cartSuggestionDetailEntity
        .limitations
        .map((e) => Limitation(
            productId: e.productId,
            profileTypeId: e.profileTypeId,
            profileTypeName: e.profileTypeName,
            day: e.day,
            qty: e.qty,
            displayName: e.displayName))
        .toList();
    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(vertical: 32, horizontal: 26),
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: CBase().dinawinWhite05),
          borderRadius: BorderRadius.circular(4.0)),
      alignment: Alignment.topCenter,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //* ---header
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: _buildHeader(),
            ),
            //*
            Divider(
              indent: 0,
              thickness: 2,
              color: CBase().dinawinWhite05,
            ),
            //*
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(
                  indent: 16,
                  endIndent: 16,
                  thickness: 2,
                  color: CBase().dinawinWhite05,
                ),
                itemCount: limitationDialogController.limitations.length,
                itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    height: 114,
                    child: LimitationItemWidget(
                        limitation:
                            limitationDialogController.limitations[index])),
              ),
            ),
            Divider(
              color: CBase().dinawinWhite05,
              thickness: 1,
            ),

            SizedBox(
              height: 24,
            ),
            Center(
              child: GetBuilder<LimitationDialogController>(builder: (context) {
                return limitationDialogController.editStatus.status ==
                        Status.Loading
                    ? SizedBox(height: 30, width: 30, child: DinawinIndicator())
                    : SizedBox(
                        height: 40,
                        width: 72,
                        child: CustomSelectButton(
                          title: 'ثبت',
                          backgroundColor: CBase().dinawinBrown01,
                          onTap: (() {
                            limitationDialogController
                                .editProductLimitations(
                                    mainLimitations:
                                        limitationDialogController.limitations)
                                .then((value) {
                              if (value) {
                                cartSuggestionDetailEntity.limitations =
                                    limitationDialogController.limitations;
                              }
                            });
                          }),
                        ),
                      );
              }),
            ),
            SizedBox(
              height: 16,
            ),
          ]),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'محدودیت فروش',
            style: CustomTypography.title16w600Brown01h18,
          ),
          GestureDetector(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.close_rounded,
                color: CBase().dinawinBrown01,
                size: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
