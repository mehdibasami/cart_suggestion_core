
import 'package:cart_suggestion_core/core/utilities/Snacki.dart';
import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/data/model/make_customer_group.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/pages/select_customer_screen.dart';
import 'package:cart_suggestion_core/features/cart_suggestion/presentation/widget/grey_textfield.dart';
import 'package:flutter/material.dart';

class InputCustomerGroupTitleModal extends StatefulWidget {
  InputCustomerGroupTitleModal({
    Key? key,
  }) : super(key: key);

  @override
  State<InputCustomerGroupTitleModal> createState() =>
      _InputCustomerGroupTitleModalState();
}

class _InputCustomerGroupTitleModalState
    extends State<InputCustomerGroupTitleModal> {
  final MakeCustomerGroup makeCustomerGroup = MakeCustomerGroup();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CBase().dinawinWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'گروه مشتری جدید',
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
                  'لطفا گروه مشتری جدید را نام گذاری کنید.',
                  style: TextStyle(
                    color: CBase().dinawinDarkGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: GreyTextField(
                          title: 'عنوان گروه',
                          onChanged: (q) {
                            makeCustomerGroup.title = q;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                InkWell(
                  onTap: () {
                    if (makeCustomerGroup.title != null &&
                        makeCustomerGroup.title!.isNotEmpty) {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SelectCustomerScreen(
                                  makeCustomerGroup: makeCustomerGroup)));
                    } else {
                      Snacki().GETSnackBar(
                          false, 'لطفا عنوان گروه مشتری را وارد کنید.');
                    }
                  },
                  child: Container(
                    width: 56.0,
                    height: 56.0,
                    padding: const EdgeInsets.all(5),
                    child: Center(
                        child: Icon(
                      Icons.arrow_forward,
                      color: CBase().dinawinWhite,
                    )),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CBase().dinawinDarkGrey,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
