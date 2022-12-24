import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    Key? key,
    this.showTryAgainBtn = true,
    this.onPressedTryAgain,
  }) : super(key: key);
  final bool showTryAgainBtn;
  final void Function()? onPressedTryAgain;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('موردی یافت نشد'),
        TextButton(onPressed: onPressedTryAgain, child: Text('تلاش دوباره'))
      ],
    );
  }
}
