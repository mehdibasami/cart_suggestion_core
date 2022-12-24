import 'dart:developer';

import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/get_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../customer_item.dart';
import './show_more_button.dart';
import './list_type_title.dart';
import './customer_groups_list_shimmer.dart';

class CustomersList extends StatefulWidget {
  CustomersList({Key? key}) : super(key: key);

  @override
  State<CustomersList> createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  // final CustomerGroupController controller = Get.put(CustomerGroupController());
  final GetUserController controller = Get.put(GetUserController());

  @override
  void initState() {
    controller.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///
        /// *----- group list
        ListTypeTitle(title: 'لیست افراد'),

        /// *----- bills list
        GetBuilder<GetUserController>(
          id: 'users',
          builder: (_) {
            log('get my users');
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
                              controller.getUsers();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('تلاش مجدد'),
                            ),
                          ),
                        ],
                      )
                    : (controller.getUserModel?.getUserValueModel?.length ??
                                0) ==
                            0
                        ? Center(child: Text('موردی یافت نشد'))

                        /// *----- list items
                        : Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: controller.getUserModel!
                                            .getUserValueModel!.length <
                                        5
                                    ? controller
                                        .getUserModel!.getUserValueModel!.length
                                    : 5,
                                itemBuilder: (ctx, i) {
                                  bool selected = controller.selectedCustomer
                                      .any((element) =>
                                          element.id ==
                                          controller.getUserModel!
                                              .getUserValueModel![i].id);
                                  return Column(
                                    children: [
                                      controller.getUserModel
                                                  ?.getUserValueModel !=
                                              null
                                          ? CustomerItem(
                                              model: controller.getUserModel!
                                                  .getUserValueModel![i],
                                              select: selected,
                                              onSelect: () {
                                                controller.selectHandler(
                                                    controller.getUserModel!
                                                        .getUserValueModel![i],
                                                    selected);
                                              },
                                            )
                                          : SizedBox(),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(height: 5),

                              /// *----- is Expanded
                              if (controller.customerIsExpanded == true)
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: controller.getUserModel!
                                          .getUserValueModel!.length -
                                      5,
                                  itemBuilder: (ctx, i) {
                                    bool selected = controller.selectedCustomer
                                        .any((element) =>
                                            element.id ==
                                            controller.getUserModel!
                                                .getUserValueModel![i + 5].id);
                                    return Column(
                                      children: [
                                        controller.getUserModel
                                                    ?.getUserValueModel !=
                                                null
                                            ? CustomerItem(
                                                model: controller.getUserModel!
                                                    .getUserValueModel![i + 5],
                                                select: selected,
                                                onSelect: () {
                                                  controller.selectHandler(
                                                    controller.getUserModel!
                                                            .getUserValueModel![
                                                        i + 5],
                                                    selected,
                                                  );
                                                },
                                              )
                                            : SizedBox(),
                                        SizedBox(height: 10),
                                      ],
                                    );
                                  },
                                ),

                              /// *----- show more button
                              ShowMoreButton(
                                onTap: () {
                                  controller.groupIsExpanded();
                                },
                                isExpanded: controller.customerIsExpanded,
                              ),
                            ],
                          );
          },
        ),
      ],
    );
  }
}
