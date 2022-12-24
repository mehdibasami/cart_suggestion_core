import 'package:cart_suggestion_core/cart_suggestion_core.dart';
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/cart_suggestion_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/submit_cart_suggestion_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SelectPurchaseTypeModal extends StatefulWidget {
  SelectPurchaseTypeModal({Key? key, required this.makeListModel})
      : super(key: key);
  final CartSuggestionItemParams makeListModel;

  @override
  State<SelectPurchaseTypeModal> createState() =>
      _SelectPurchaseTypeModalState();
}

class _SelectPurchaseTypeModalState extends State<SelectPurchaseTypeModal> {
  SubmitCartSuggestionController _submitCartSuggestionController =
      Get.put(SubmitCartSuggestionController());

  @override
  void initState() {
    super.initState();
    widget.makeListModel.isAllOrginal = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      color: CBase().dinawinWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'نوع پرداخت',
                style: TextStyle(
                  color: CBase().dinawinDarkGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'لطفا نوع پرداخت کالاها را انتخاب کنید.',
                style: TextStyle(
                  color: CBase().dinawinDarkGrey,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.makeListModel.isAllOrginal = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            RadioButton(
                              color: widget.makeListModel.isAllOrginal == true
                                  ? CBase().dinawinBrown
                                  : CBase().dinawinDarkGrey,
                              value: true,
                              groupValue: widget.makeListModel.isAllOrginal,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'نقدی',
                              style: TextStyle(
                                color: widget.makeListModel.isAllOrginal == true
                                    ? CBase().dinawinBrown
                                    : CBase().dinawinDarkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.makeListModel.isAllOrginal = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            RadioButton(
                              color: widget.makeListModel.isAllOrginal == false
                                  ? CBase().dinawinBrown
                                  : CBase().dinawinDarkGrey,
                              value: false,
                              groupValue: widget.makeListModel.isAllOrginal,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'نقدی و اعتباری',
                              style: TextStyle(
                                color:
                                    widget.makeListModel.isAllOrginal == false
                                        ? CBase().dinawinBrown
                                        : CBase().dinawinDarkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 50),
              GetBuilder<SubmitCartSuggestionController>(
                id: 'button',
                builder: (_) {
                  return InkWell(
                    onTap:
                        _submitCartSuggestionController.submitStatus.status ==
                                Status.Loading
                            ? null
                            : () {
                                _submitCartSuggestionController
                                    .submit(widget.makeListModel)
                                    .then((value) {
                                  if (value) {
                                    CartSuggestionController
                                        cartSuggestionController = Get.find();
                                    cartSuggestionController
                                        .cartSuggestionPagingController
                                        .refresh();

                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                                });
                              },
                    child: Container(
                      // padding: const EdgeInsets.symmetric(
                      //     vertical: 16, horizontal: 24),
                      width: 70,
                      height: 45,
                      decoration: BoxDecoration(
                        color: CBase().dinawinBrown,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: _submitCartSuggestionController
                                    .submitStatus.status ==
                                Status.Loading
                            ? SizedBox(
                                height: 24,
                                width: 24,
                                child: DinawinIndicator(
                                  color: CBase().backgroundColor,
                                ),
                              )
                            : Text(
                                'ثبت',
                                style: TextStyle(
                                  color: CBase().pureWhite,
                                ),
                              ),
                      ),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class RadioButton extends StatelessWidget {
  const RadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    this.size = 18.0,
    this.color = Colors.black,
  }) : super(key: key);
  final dynamic value;
  final dynamic groupValue;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: color,
          )),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value == groupValue ? color : Colors.transparent,
        ),
      ),
    );
  }
}
