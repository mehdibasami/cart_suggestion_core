import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/customer_group_data.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/edit_usergroup/edit_usergroup_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerEditItem extends StatelessWidget {
  final CustomerModel model;
  final void Function()? onRemove;
  final bool select;
  const CustomerEditItem({
    Key? key,
    required this.onRemove,
    required this.model,
    required this.select,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          GetBuilder<EditUserGroupController>(
              id: '${model.id}',
              builder: (controller) {
                return controller.deleteStatus.status == Status.Loading
                    ? CircularProgressIndicator()
                    : Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onRemove,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              CupertinoIcons.delete,
                              color: CBase().dinawinDarkGrey,
                            ),
                          ),
                        ),
                      );
              }),
        ],
      ),
    );
  }
}
