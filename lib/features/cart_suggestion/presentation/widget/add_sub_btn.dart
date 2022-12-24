import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddSubButton extends StatelessWidget {
  final Widget? icon;
  final Color? fillColor;
  final Color? borderColor;
  final Color? iconColor;

  const AddSubButton({
    Key? key,
    this.icon,
    this.fillColor,
    this.borderColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      width: 39,
      decoration: BoxDecoration(
        color: fillColor ?? CBase().dinawinBrown01,
        border: Border.all(width: 1, color: borderColor ?? Colors.transparent),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: icon ?? SvgPicture.asset(Constants.addIcon2),
      ),
    );
  }
}
