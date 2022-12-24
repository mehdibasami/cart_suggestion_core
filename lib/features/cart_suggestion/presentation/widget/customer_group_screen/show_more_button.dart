import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';


class ShowMoreButton extends StatelessWidget {
  final Function onTap;
  final bool isExpanded;
  const ShowMoreButton({
    required this.onTap,
    required this.isExpanded,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                isExpanded ? 'مشاهده کمتر' : 'مشاهده بیشتر',
                style: TextStyle(color: CBase().dinawinBlack01),
              ),
              Icon(
                isExpanded
                    ? Icons.expand_less_rounded
                    : Icons.expand_more_rounded,
                color: CBase().dinawinBlack01,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
