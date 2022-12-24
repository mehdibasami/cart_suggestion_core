import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
  final String title;
  // final String? initialValue;
  final Function(String) onchange;
  // final String? Function(String?)? validator;
  // final bool defaultDecoration;
  final TextEditingController? controller;
  const CustomTextField({
    Key? key,
    required this.title,
    // this.initialValue,
    this.controller,
    // this.defaultDecoration = true,
    // this.validator,
    required this.onchange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: EdgeInsets.fromLTRB(30, 0, 30, 15),
      padding: EdgeInsets.only(right: 10, bottom: 8),
      decoration: BoxDecoration(
        color: CBase().dinawinDarkGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          style: TextStyle(color: CBase().dinawinDarkGrey),
          onChanged: onchange,
          decoration: InputDecoration(
            // filled: true,
            // fillColor: CBase().dinawinDarkGrey.withOpacity(0.1) ,
            border: InputBorder.none,
            hintText: title,
            hintStyle: TextStyle(
              color: CBase().dinawinDarkGrey.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
