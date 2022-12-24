import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class GreyTextField extends StatelessWidget {
  final TextInputType? inputType;
  final TextEditingController? controller;
  Function(String)? onChanged;
  final String title;
  final bool? enable;
  final List<TextInputFormatter>? inputFormatter;

  GreyTextField({
    Key? key,
    required this.title,
    this.inputType,
    this.inputFormatter,
    this.enable = true,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: CBase().backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: CBase().dinawinWidth(context) / 9,
              child: TextField(
                enabled: enable,
                controller: controller,
                keyboardType: inputType,
                inputFormatters: inputFormatter,
                onChanged: (s) {
                  if (onChanged != null) {
                    onChanged!(s);
                  }
                },
                style: TextStyle(
                  fontSize: 16,
                  color: CBase().dinawinDarkGrey,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(bottom: 5),
                  hintText: title,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: CBase().dinawinDarkGrey.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
