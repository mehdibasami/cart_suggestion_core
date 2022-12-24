
import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/make_customer_group.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/edit_usergroup/edit_usergroup_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/get_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'customer_modal_item.dart';

class ConfirmAddUserToGroupItem extends StatelessWidget {
  ConfirmAddUserToGroupItem(
      {Key? key,
      required this.makeCustomerGroup,
      required this.onTapConfirmed,
      required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;
  final void Function()? onTapConfirmed;
  final MakeCustomerGroup makeCustomerGroup;
  final GetUserController controller = Get.find();
  // final EditUserGroupController editUserGroupController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: CBase().dinawinWhite,
        height: MediaQuery.of(context).size.height / 1.3,
        child: ListView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          // shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: GetBuilder<GetUserController>(
                  id: 'users',
                  builder: (_) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  '${makeCustomerGroup.id}',
                                  style: TextStyle(
                                    color: CBase().dinawinDarkGrey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: CBase().dinawinWhite,
                                )),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CBase().dinawinDarkGrey,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   'لطفا گروه مشتری جدید را نام گذاری کنید.',
                        //   style: TextStyle(
                        //     color: CBase().dinawinDarkGrey,
                        //   ),
                        // ),
                        for (int i = 0;
                            i < controller.selectedCustomer.length;
                            i++)
                          CustomerModalItem(
                            model: controller.selectedCustomer[i],
                            onRemove: () {
                              controller.selectHandler(
                                  controller.selectedCustomer[i], true);
                            },
                            select: false,
                          ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                      ],
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: GetBuilder<EditUserGroupController>(
                id: 'addUsersStatus',
                builder: (editUserGroupController) {
                  return InkWell(
                    onTap: onTapConfirmed,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                          child:
                              editUserGroupController.addUsersStatus.status ==
                                      Status.Loading
                                  ? DinawinIndicator()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'ثبت',
                                        style: TextStyle(
                                            color: CBase().dinawinWhite,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                      decoration: BoxDecoration(
                          color: CBase().dinawinDarkGrey,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}

class RadioButton extends StatelessWidget {
  const RadioButton(
      {Key? key,
      required this.value,
      required this.groupValue,
      this.size = 18.0,
      this.color = Colors.black})
      : super(key: key);
  final dynamic value;
  final dynamic groupValue;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: color,
          )),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value == groupValue ? color : Colors.transparent,
        ),
      ),
    );
  }
}
