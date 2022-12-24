import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final double size;
  final bool isSelected;
  final Color? color;
  const CustomRadioButton({
    Key? key,
    this.size = 16.0,
    this.color,
    required this.isSelected,
  }) : super(key: key);

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
            color: color ?? CBase().dinawinBrown02,
          )),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              isSelected ? color ?? CBase().dinawinBrown02 : Colors.transparent,
        ),
      ),
    );
  }
}
