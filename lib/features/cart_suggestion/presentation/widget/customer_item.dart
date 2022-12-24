import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/get_user_value_model.dart';
import 'package:flutter/material.dart';

class CustomerItem extends StatelessWidget {
  final GetUserValueModel model;
  final onSelect;
  final bool select;
  const CustomerItem({
    Key? key,
    required this.onSelect,
    required this.model,
    required this.select,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelect();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.all(10),
        // height: 50,
        decoration: BoxDecoration(
          color: CBase().dinawinWhite,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: select ? CBase().dinawinBrown : CBase().dinawinWhite,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.account_circle_outlined,
              color: CBase().dinawinDarkGrey,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.fullName.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: CBase().dinawinDarkGrey.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    model.phoneNumber.toString(),
                    style: TextStyle(
                      color: CBase().dinawinDarkGrey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
