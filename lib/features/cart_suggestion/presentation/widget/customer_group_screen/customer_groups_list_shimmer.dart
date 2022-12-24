import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';

class CustomerGroupsListShimmer extends StatelessWidget {
  const CustomerGroupsListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, i) => Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            height: 50,
            decoration: BoxDecoration(
              color: CBase().dinawinWhite05,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
