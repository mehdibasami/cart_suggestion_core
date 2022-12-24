import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';


class TopAddBtn extends StatelessWidget {
  const TopAddBtn({Key? key, required this.onTap, required this.title})
      : super(key: key);
  final Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.all(0),
        // height: 50,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title.toString(),
              style: TextStyle(
                  color: CBase().dinawinDarkGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              width: 30,
              height: 30,
              child: Center(
                child: Icon(
                  Icons.add,
                  color: CBase().dinawinWhite,
                  size: 18,
                ),
              ),
              decoration: BoxDecoration(
                color: CBase().dinawinDarkGrey,
                shape: BoxShape.circle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
