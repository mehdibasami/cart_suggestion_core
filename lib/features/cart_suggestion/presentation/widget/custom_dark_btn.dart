import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';


class CustomDarkBtn extends StatelessWidget {
  final Function ontap;
  final String title;
  const CustomDarkBtn({
    Key? key,
    required this.ontap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: CBase().dinawinBrown,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: CBase().dinawinWhite,
            ),
          ),
        ),
      ),
    );
  }
}
