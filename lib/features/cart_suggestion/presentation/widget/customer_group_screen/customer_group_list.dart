import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/customer_group_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'customer_group_item.dart';
import 'show_more_button.dart';
import './list_type_title.dart';
import 'customer_groups_list_shimmer.dart';

class CustomerGroupList extends StatelessWidget {
  CustomerGroupList({Key? key}) : super(key: key);

  final CustomerGroupController controller = Get.put(CustomerGroupController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///
        /// *----- group list
        ListTypeTitle(title: 'لیست گروه ها'),

        /// *----- bills list
        GetBuilder<CustomerGroupController>(
          id: 'customers',
          builder: (_) {
            return controller.getStatus.status == Status.Loading

                /// *----- loading
                ? const Center(child: CustomerGroupsListShimmer())

                /// *----- error
                : controller.getStatus.status == Status.Error
                    ? Column(
                        children: [
                          Text(controller.getStatus.message),
                          InkWell(
                            onTap: () {
                              controller.getCustomers();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('تلاش مجدد'),
                            ),
                          ),
                        ],
                      )
                    : (controller.customerGroupData.customerGroups?.length ??
                                0) ==
                            0
                        ? Center(child: Text('موردی یافت نشد'))

                        /// *----- list items
                        : Column(
                            children: [
                              // ListView.builder(
                              //   shrinkWrap: true,
                              //   physics: ClampingScrollPhysics(),
                              //   itemCount: controller.customerGroupData
                              //               .customerGroups!.length <
                              //           5
                              //       ? controller.customerGroupData
                              //           .customerGroups!.length
                              //       : 5,
                              //   itemBuilder: (ctx, i) => Column(
                              //     children: [
                              //       controller.customerGroupData
                              //                   .customerGroups?[i] !=
                              //               null
                              //           ? CustomerGroupItem(
                              //               select:
                              //                   controller.selectedGroup?.id ==
                              //                       controller.customerGroupData
                              //                           .customerGroups![i].id,
                              //               onSelect: () {
                              //                 controller.setSelected(controller
                              //                     .customerGroupData
                              //                     .customerGroups![i]);
                              //               },
                              //               onDisable: () {
                              //                 controller.getCustomers();
                              //               },
                              //               model: controller.customerGroupData
                              //                   .customerGroups![i],
                              //             )
                              //           : SizedBox(),
                              //       SizedBox(height: 10),
                              //     ],
                              //   ),
                              // ),

                              /// *----- is Expanded
                              // if (controller.customerGroupIsExpanded == true)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: controller
                                    .customerGroupData.customerGroups!.length,
                                itemBuilder: (ctx, i) => Column(
                                  children: [
                                    controller.customerGroupData
                                                .customerGroups?[i] !=
                                            null
                                        ? CustomerGroupItem(
                                            select:
                                                controller.selectedGroup?.id ==
                                                    controller.customerGroupData
                                                        .customerGroups![i].id,
                                            onSelect: () {
                                              controller.setSelected(
                                                controller.customerGroupData
                                                    .customerGroups![i],
                                              );
                                            },
                                            onDisable: () {
                                              controller.getCustomers();
                                            },
                                            model: controller.customerGroupData
                                                .customerGroups![i],
                                          )
                                        : SizedBox(),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
//TODO
                              /// *----- show more button
                              // ShowMoreButton(
                              //   onTap: () {
                              //     controller.groupIsExpanded();
                              //   },
                              //   isExpanded: controller.customerGroupIsExpanded,
                              // ),
                            ],
                          );
          },
        ),
      ],
    );
  }
}
