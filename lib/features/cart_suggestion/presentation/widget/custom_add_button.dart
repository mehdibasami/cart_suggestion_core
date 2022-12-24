import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';


class CustomAddButton extends StatelessWidget {
  final Function onTap;
  const CustomAddButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: CBase().dinawinDarkGrey,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.add_rounded,
            color: CBase().dinawinWhite,
          ),
        ),
      ),
    );
  }
}
