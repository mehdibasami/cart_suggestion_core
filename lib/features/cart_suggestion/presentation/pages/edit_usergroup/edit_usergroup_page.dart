import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/customer_group_data.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/make_customer_group.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/edit_usergroup/edit_usergroup_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/edit_usergroup/add_user_to_group_page.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/customer_edit_item.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/second_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/custom_dark_btn.dart';
import '../../widget/search_widget.dart';

class EditUserGroupPage extends StatefulWidget {
  static const routeName = '/editUserGroup';
  final CustomerGroup customerGroup;
  EditUserGroupPage({
    Key? key,
    required this.customerGroup,
  }) : super(key: key);

  @override
  State<EditUserGroupPage> createState() => _EditUserGroupPageState();
}

class _EditUserGroupPageState extends State<EditUserGroupPage> {
  //*----- controller
  EditUserGroupController controller = Get.put(EditUserGroupController());
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    controller.getUsersOfGroup(groupId: widget.customerGroup.id ?? 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<EditUserGroupController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondAppBar(title: 'اعضای گروه'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 10),
                  //*----- search box
                  SearchWidget(
                    controller: textEditingController,
                    onSearch: (value) {
                      controller.search(value);
                    },
                  ),
                  SizedBox(height: 15),

                  //*----- customers list
                  GetBuilder<EditUserGroupController>(
                      id: 'getUsersStatus',
                      builder: (_) {
                        if (controller.getUsersStatus.status ==
                            Status.Loading) {
                          return const Center(child: DinawinIndicator());
                        }

                        if (controller.getUsersStatus.status == Status.Error) {
                          return Column(
                            children: [
                              Text(controller.getUsersStatus.message),
                              InkWell(
                                  onTap: () {
                                    controller.getUsersOfGroup(
                                        groupId: widget.customerGroup.id ?? 0);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('تلاش مجدد'),
                                  )),
                            ],
                          );
                        }
                        if (controller.selectedGroupItemsFiltered.length > 0)
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount:
                                controller.selectedGroupItemsFiltered.length,
                            itemBuilder: (ctx, i) {
                              return Column(
                                children: [
                                  CustomerEditItem(
                                    model: controller
                                        .selectedGroupItemsFiltered[i],
                                    select: false,
                                    onRemove: controller.onTapRemove(
                                        userItemId: controller
                                                .selectedGroupItemsFiltered[i]
                                                .id ??
                                            0,
                                        groupId: widget.customerGroup.id),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              );
                            },
                          );

                        return Center(child: Text('موردی یافت نشد'));
                      }),
                ],
              ),
            ),
            GetBuilder<EditUserGroupController>(
                id: 'button',
                builder: (_) {
                  return CustomDarkBtn(
                    ontap: () {
                      Get.to(() => AddUserToGroupPage(
                            makeCustomerGroup: MakeCustomerGroup(
                                title: controller.selectedGroup.title,
                                id: widget.customerGroup.id,
                                userIds: controller.selectedGroup.items
                                        ?.map((e) => e.userId ?? 0)
                                        .toList() ??
                                    []),
                          ));
                    },
                    title: 'اضافه کردن کاربر',
                  );
                }),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
