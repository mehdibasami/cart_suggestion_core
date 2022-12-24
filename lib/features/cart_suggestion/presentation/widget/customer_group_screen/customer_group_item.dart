import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/values/typography.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/customer_group_data.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/get_user_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/edit_usergroup/edit_usergroup_page.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/history/group_history_page.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomerGroupItem extends StatelessWidget {
  final CustomerGroup model;
  final onSelect;
  final Function onDisable;
  final bool select;
  const CustomerGroupItem({
    Key? key,
    required this.onSelect,
    required this.onDisable,
    required this.model,
    required this.select,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetUserController());
    const double _padding = 10.0;
    return InkWell(
      onTap: () {
        onSelect();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        // padding: EdgeInsets.all(10),
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
            Padding(
              padding: const EdgeInsets.all(_padding),
              child: Icon(
                Icons.account_circle_outlined,
                color: CBase().dinawinDarkGrey,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(_padding),
                  child: Text(
                    model.title.toString(),
                    style: TextStyle(
                      color: CBase().dinawinDarkGrey,
                    ),
                  ),
                ),
              ),
            ),
            GetBuilder<GetUserController>(
                id: '${model.id}',
                builder: (ctx) => Column(
                      children: [
                        if (controller.disableStatus.status == Status.Loading)
                          SizedBox(
                              width: 20, height: 20, child: DinawinIndicator()),
                      ],
                    )),
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(
                      Icons.history,
                      color: CBase().dinawinBrown,
                    ),
                    title: Text('تاریخچه گروه',
                        style: CustomTypography.dialogContent),
                    onTap: () {
                      Get.back();

                      Get.to(GroupHistoryPage(
                        userGroupId: model.id ?? 0,
                        userGroupName: model.title ?? '',
                      ));
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(
                      Icons.edit,
                      color: CBase().dinawinBrown,
                    ),
                    title: Text('ویرایش گروه',
                        style: CustomTypography.dialogContent),
                    onTap: () {
                      Get.back();

                      Get.to(() => EditUserGroupPage(customerGroup: model));
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(
                      Icons.delete,
                      color: CBase().dinawinBrown,
                    ),
                    title:
                        Text('حذف گروه', style: CustomTypography.dialogContent),
                    onTap: () {
                      Get.back();
                      showDialog(
                          context: context,
                          builder: (context) =>
                              _alertDeleteDialog(context, onDelete: () async {
                                if (await controller.disableUserGroup(
                                    userGroupId: model.id ?? 0)) {
                                  onDisable();
                                }
                              }));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _alertDeleteDialog(BuildContext context,
      {required Function() onDelete}) {
    return AlertDialog(
      title: Text('آیا از حذف این مورد اطمینان دارید؟'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('خیر')),
        TextButton(
            onPressed: () {
              onDelete();
              Navigator.pop(context);
            },
            child: Text('بله')),
      ],
    );
  }
}
