import 'package:cart_suggestion_core/core/model/request_status.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/widgets/dinawin_indicator.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/controller/customer_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectMessegeMethod extends StatefulWidget {
  final int id;
  SelectMessegeMethod({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<SelectMessegeMethod> createState() => _SelectMessegeMethodState();
}

class _SelectMessegeMethodState extends State<SelectMessegeMethod> {
  /// *controller
  final CustomerGroupController controller = Get.put(CustomerGroupController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      color: CBase().dinawinWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'انتخاب مشتری',
                style: TextStyle(
                  color: CBase().dinawinDarkGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'لطفا لیست مشتری را انتخاب کنید.',
                style: TextStyle(
                  color: CBase().dinawinDarkGrey,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///
                    /// *----- sms
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (controller.selectedMessenger
                              .contains(Messenger.sms)) {
                            controller.selectedMessenger.remove(Messenger.sms);
                          } else {
                            controller.selectedMessenger.add(Messenger.sms);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            RadioButton(
                              isActive: controller.selectedMessenger
                                  .contains(Messenger.sms),
                              color: controller.selectedMessenger
                                      .contains(Messenger.sms)
                                  ? CBase().dinawinBrown
                                  : CBase().dinawinDarkGrey,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'پیامک',
                              style: TextStyle(
                                color: controller.selectedMessenger
                                        .contains(Messenger.sms)
                                    ? CBase().dinawinBrown
                                    : CBase().dinawinDarkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// *----- telegram
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (controller.selectedMessenger
                              .contains(Messenger.telegram)) {
                            controller.selectedMessenger
                                .remove(Messenger.telegram);
                          } else {
                            controller.selectedMessenger
                                .add(Messenger.telegram);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            RadioButton(
                              isActive: controller.selectedMessenger
                                  .contains(Messenger.telegram),
                              color: controller.selectedMessenger
                                      .contains(Messenger.telegram)
                                  ? CBase().dinawinBrown
                                  : CBase().dinawinDarkGrey,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'تلگرام',
                              style: TextStyle(
                                color: controller.selectedMessenger
                                        .contains(Messenger.telegram)
                                    ? CBase().dinawinBrown
                                    : CBase().dinawinDarkGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              GetBuilder<CustomerGroupController>(
                id: 'button',
                builder: (_) {
                  return controller.postStatus.status == Status.Loading
                      ? Center(
                          child: SizedBox(
                            height: 28,
                            width: 28,
                            child: DinawinIndicator(),
                          ),
                        )
                      : InkWell(
                          onTap: controller.getStatus.status == Status.Loading
                              ? null
                              : () {
                                  for (var element
                                      in controller.selectedMessenger) {
                                    switch (element) {
                                      case Messenger.sms:
                                        {
                                          controller.sendLinkHandler(widget.id);
                                        }
                                        break;
                                      case Messenger.telegram:
                                        {
                                          controller.sendLinkHandlerByTelegram(
                                            widget.id,
                                          );
                                        }
                                        break;
                                      default:
                                        controller.sendLinkHandler(widget.id);
                                    }
                                  }
                                },
                          child: Center(
                              child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
                            decoration: BoxDecoration(
                              color: CBase().dinawinBrown,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                'ثبت',
                                style: TextStyle(
                                  color: CBase().pureWhite,
                                ),
                              ),
                            ),
                          )),
                        );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class RadioButton extends StatelessWidget {
  final double size;
  final Color color;
  final bool isActive;
  const RadioButton({
    Key? key,
    this.size = 18.0,
    this.color = Colors.black,
    required this.isActive,
  }) : super(key: key);

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
          color: isActive == true ? color : Colors.transparent,
        ),
      ),
    );
  }
}

enum Messenger {
  sms,
  telegram,
}
