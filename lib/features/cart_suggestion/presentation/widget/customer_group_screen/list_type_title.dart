import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';


class ListTypeTitle extends StatelessWidget {
  final String title;
  const ListTypeTitle({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            title,
            style: TextStyle(
              color: CBase().dinawinBrown02,
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
