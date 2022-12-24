import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/customer_group_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/select_messege_method.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/custom_dark_btn.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/input_customer_group_title_modal.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/top_add_btn.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../widget/customer_group_screen/customer_group_list.dart';
import '../widget/search_widget.dart';
import '../widget/second_app_bar.dart';

class SelectCustomerGroupPage extends StatelessWidget {
  SelectCustomerGroupPage({Key? key, required this.cartSuggestionId})
      : super(key: key);

  final int cartSuggestionId;
  final CustomerGroupController controller = Get.put(CustomerGroupController());
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondAppBar(
        title: 'گروه های مشتری'.tr,
      ),
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
                    onSearch: ((q) {
                      controller.search(q);
                    }),
                  ),
                  SizedBox(height: 20),

                  //*----- create new group
                  TopAddBtn(
                    onTap: () {
                      /// input group title
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => InputCustomerGroupTitleModal());
                    },
                    title: 'ساختن گروه جدید',
                  ),
                  SizedBox(height: 16),

                  /// *----- customer group list
                  CustomerGroupList(),
                  SizedBox(height: 16),
//TODO
                  //*----- users list
                  // CustomersList(),
                ],
              ),
            ),
            GetBuilder<CustomerGroupController>(
                id: 'button',
                builder: (_) {
                  return controller.postStatus.status == Status.Loading
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: DinawinIndicator(),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: CustomDarkBtn(
                            ontap: () {
                              // _alertDeleteDialog(context, onConfirm: () {
                              //   controller.sendLinkHandler(cartSuggestionId);
                              // });

                              if ((controller.customerGroupData.customerGroups
                                      ?.length) !=
                                  0) {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (ctx) =>
                                      SelectMessegeMethod(id: cartSuggestionId),
                                );
                              } else {
                                Snacki().GETSnackBar(
                                  false,
                                  'هیچ مشتری ای انتخاب نشده است.',
                                );
                              }
                            },
                            title: 'ارسال برای مشتری',
                          ),
                        );
                }),
          ],
        ),
      ),

      // // *----- floating action btn
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Get.to(() => MakeBillScreen());
      //   },
      //   backgroundColor: CBase().dinawinDarkGrey,
      //   child: Center(
      //     child: Icon(
      //       Icons.add_rounded,
      //       color: CBase().dinawinWhite,
      //     ),
      //   ),
      // ),
    );
  }
}

_alertDeleteDialog(BuildContext context, {required Function() onConfirm}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('آیااطمینان دارید؟'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('خیر', style: TextStyle(color: CBase().dinawinBrown))),
        TextButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            child: Text('بله', style: TextStyle(color: CBase().dinawinBrown))),
      ],
    ),
  );
}
