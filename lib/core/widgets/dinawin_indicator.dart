import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';


class DinawinIndicator extends StatelessWidget {
  final Color? color;
  const DinawinIndicator({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(color ?? CBase().dinawinBrown),
    );
  }
}
