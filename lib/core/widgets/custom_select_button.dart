
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/values/typography.dart';
import 'package:flutter/material.dart';

class CustomSelectButton extends StatelessWidget {
  const CustomSelectButton(
      {Key? key,
      this.onTap,
      this.backgroundColor,
      this.padding,
      required this.title,
      this.textColor})
      : super(key: key);
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final String title;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(width: 1, color: CBase().dinawinBrown01),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 1,
              style: CustomTypography.btnTitle12w600(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
