import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/values/constants.dart';
import 'package:cart_suggestion_core/core/values/typography.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/limitation_model.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/add_sub_btn.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class LimitationItemWidget extends StatefulWidget {
  const LimitationItemWidget({
    Key? key,
    required this.limitation,
  }) : super(key: key);

  final Limitation limitation;

  @override
  State<LimitationItemWidget> createState() => _LimitationItemWidgetState();
}

class _LimitationItemWidgetState extends State<LimitationItemWidget> {
  @override
  Widget build(BuildContext context) {
    final qtyTextController = TextEditingController(
        text: widget.limitation.qty.toString().toPersianDigit());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Text(
            widget.limitation.displayName + ' : ',
            style: CustomTypography.title16w600Brown01h18,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              SizedBox(
                width: 4,
              ),
              Text(
                'تعداد',
                style: CustomTypography.title16w600Black02h18,
              ),
              SizedBox(
                width: 8,
              ),
              GestureDetector(
                  onTap: () {
                    widget.limitation.qty++;
                    setState(() {});
                  },
                  child: AddSubButton()),
              SizedBox(
                width: 8,
              ),
              _buildTextFormField(qtyTextController),
              SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  widget.limitation.qty--;
                  setState(() {});
                },
                child: AddSubButton(
                  icon: Container(
                    height: 1,
                    width: 14,
                    decoration: BoxDecoration(
                        color: CBase().dinawinBrown01,
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  fillColor: Colors.transparent,
                  borderColor: CBase().dinawinBrown01,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                'روز',
                style: CustomTypography.title16w600Black02h18,
              ),
              SizedBox(
                width: 16,
              ),
              CustomPopupMenu(
                menuBuilder: () {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      decoration: BoxDecoration(
                          color: CBase().pureWhite,
                          borderRadius: BorderRadius.circular(4)),
                      child: NumberPicker(
                          value: widget.limitation.day,
                          minValue: 0,
                          textMapper: (numberText) =>
                              numberText.toPersianDigit(),
                          decoration: BoxDecoration(
                              border: Border.symmetric(
                                  horizontal: BorderSide(
                                      width: 1,
                                      color: CBase().dinawinBrown01))),
                          infiniteLoop: true,
                          maxValue: 365,
                          onChanged: (value) {
                            widget.limitation.day = value;
                            setState(() {});
                          }),
                    );
                  });
                },
                menuOnChange: (p0) {
                  setState(() {});
                },
                pressType: PressType.singleClick,
                child: Container(
                  height: 40,
                  width: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border:
                          Border.all(width: 1, color: CBase().dinawinBrown01)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.limitation.day.toString().toPersianDigit()),
                      SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset(Constants.arrowUpIcon)
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  SizedBox _buildTextFormField(TextEditingController qtyTextController) {
    return SizedBox(
      width: 57,
      height: 40,
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(r'[0-9]*[۰-۹]*'),
          ),
        ],
        controller: qtyTextController,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16, height: 18 / 16, color: CBase().dinawinBlack02),
        // initialValue: widget.limitation.qty.toString().toPersianDigit(),
        onChanged: (newValue) {
          widget.limitation.qty = int.parse(newValue.toEnglishDigit());
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: CBase().dinawinBrown01,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: CBase().dinawinBrown01,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4)),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: CBase().dinawinBrown01,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4)),
          contentPadding: const EdgeInsets.all(0),
        ),
      ),
    );
  }
}
