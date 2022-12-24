import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/make_customer_group.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/customer_group_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/get_user_controller.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/confirm_customers_modal.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/customer_item.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/second_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/custom_dark_btn.dart';
import '../widget/search_widget.dart';

class SelectCustomerScreen extends StatefulWidget {
  final MakeCustomerGroup makeCustomerGroup;
  SelectCustomerScreen({
    Key? key,
    required this.makeCustomerGroup,
  }) : super(key: key);

  @override
  State<SelectCustomerScreen> createState() => _SelectCustomerScreenState();
}

class _SelectCustomerScreenState extends State<SelectCustomerScreen> {
  //*----- controller
  GetUserController controller = Get.put(GetUserController());
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    controller.getUsers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<GetUserController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondAppBar(title: 'انتخاب مشتری'),
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
                    onSearch: (q) {
                      controller.search(q);
                    },
                  ),
                  SizedBox(height: 15),

                  //*----- customers list
                  GetBuilder<GetUserController>(
                      id: 'users',
                      builder: (_) {
                        return controller.getStatus.status == Status.Loading
                            ? const Center(child: DinawinIndicator())
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
                                          )),
                                    ],
                                  )
                                : (controller.getUserModel?.getUserValueModel
                                                ?.length ??
                                            0) ==
                                        0
                                    ? Center(child: Text(''))
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: controller.getUserModel
                                                ?.getUserValueModel?.length ??
                                            0,
                                        itemBuilder: (ctx, i) {
                                          bool selected = controller
                                              .selectedCustomer
                                              .any((element) =>
                                                  element.id ==
                                                  controller
                                                      .getUserModel!
                                                      .getUserValueModel![i]
                                                      .id);
                                          return Column(
                                            children: [
                                              controller.getUserModel
                                                          ?.getUserValueModel !=
                                                      null
                                                  ? CustomerItem(
                                                      model: controller
                                                          .getUserModel!
                                                          .getUserValueModel![i],
                                                      select: selected,
                                                      onSelect: () {
                                                        controller.selectHandler(
                                                            controller
                                                                .getUserModel!
                                                                .getUserValueModel![i],
                                                            selected);
                                                      },
                                                    )
                                                  : SizedBox(),
                                              SizedBox(height: 10),
                                            ],
                                          );
                                        },
                                      );
                      }),
                ],
              ),
            ),
            GetBuilder<GetUserController>(
                id: 'button',
                builder: (_) {
                  return controller.postStatus.status == Status.Loading
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: DinawinIndicator(),
                          ),
                        )
                      : CustomDarkBtn(
                          ontap: () {
                            if ((controller.selectedCustomer.length) != 0) {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                isDismissible: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => DraggableScrollableSheet(
                                  expand: false,
                                  key: UniqueKey(),
                                  initialChildSize: 0.5,
                                  maxChildSize: 0.9,
                                  minChildSize: .5,
                                  builder: (context, scrollController) =>
                                      ConfirmCustomersModal(
                                    makeCustomerGroup: widget.makeCustomerGroup,
                                    scrollController: scrollController,
                                    onTapConfirmed: () {
                                      controller
                                          .createNewGroup(
                                              widget.makeCustomerGroup)
                                          .then((value) {
                                        if (value) {
                                          final CustomerGroupController
                                              _customerGroupController =
                                              Get.find();
                                          _customerGroupController
                                              .getCustomers();
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              );
                            } else {
                              Snacki().GETSnackBar(
                                false,
                                'هیچ مشتری انتخاب نشده است.',
                              );
                            }
                          },
                          title: 'ساخت گروه مشتری',
                        );
                }),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
