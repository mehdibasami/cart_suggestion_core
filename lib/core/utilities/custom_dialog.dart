
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/core/values/constants.dart';
import 'package:cart_suggestion_core/core/widgets/custom_select_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String alertText;
  final void Function()? onTapYes;
  final void Function()? onTapNo;
  final Widget? alertIcon;
  final Widget? subTitle;
  final bool showAlertIcon;

  CustomDialog({
    this.title = '',
    this.subTitle,
    this.alertText = '',
    this.onTapNo,
    this.onTapYes,
    this.showAlertIcon = true,
    this.alertIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CBase().pureWhite,
      insetPadding: EdgeInsets.all(24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 24.0, left: 24, right: 24, bottom: 4),
        child: Wrap(children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showAlertIcon)
                    Row(
                      children: [
                        alertIcon ?? SvgPicture.asset(Constants.alertIcon),
                        SizedBox(
                          width: 16,
                        )
                      ],
                    ),
                  Text(
                    title,
                  ),
                ],
              ),
              if (subTitle != null)
                Column(children: [
                  SizedBox(
                    height: 12,
                  ),
                  subTitle!
                ]),
              SizedBox(
                height: 20,
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
              ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 16),
                shrinkWrap: true,
                children: [
                  Text(
                    alertText,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSelectButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        title: 'خیر',
                        onTap: onTapNo ??
                            () {
                              Get.back();
                            },
                        textColor: CBase().dinawinBrown01,
                        backgroundColor: CBase().dinawinWhite01,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CustomSelectButton(
                        title: 'بلی',
                        onTap: onTapYes,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        textColor: CBase().dinawinWhite01,
                        backgroundColor: CBase().dinawinBrown01,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
