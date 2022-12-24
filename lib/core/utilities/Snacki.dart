import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snacki with ChangeNotifier {
  // Future<void> showExitSnack(GlobalKey<ScaffoldState> scaffold) async {
  //   final snackBar = SnackBar(
  //     duration: Duration(seconds: 7),
  //     content: Container(
  //         height: 50.0,
  //         child: Row(
  //           children: [
  //             Flexible(
  //               fit: FlexFit.tight,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     "خروج از برنامه",
  //                     style: TextStyle(
  //                       fontSize: CBase().getTextfontSizeByScreen(),
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.orangeAccent,
  //                     ),
  //                   ),
  //                   Text(
  //                     "آیا مایل به خروج از برنامه هستید ؟",
  //                     style: TextStyle(
  //                         fontSize: CBase().getTextfontSizeByScreen()),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(
  //               width: 10.0,
  //             ),
  //             Row(
  //               children: [
  //                 InkWell(
  //                   child: Container(
  //                     width: 50.0,
  //                     padding: EdgeInsets.all(5.0),
  //                     margin: EdgeInsets.all(5.0),
  //                     decoration: BoxDecoration(
  //                       color: CBase().basePrimaryColor,
  //                       borderRadius: BorderRadius.circular(5.0),
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         "بله",
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: CBase().getTextfontSizeByScreen(),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   onTap: () {
  //                     LoginController loginController =
  //                         Get.put(LoginController());
  //                     loginController.exitApp();

  //                     Navigator.pushAndRemoveUntil(
  //                         Get.context!,
  //                         MaterialPageRoute(builder: (context) => LoginPage()),
  //                         (route) => false);
  //                   },
  //                 ),
  //                 InkWell(
  //                   child: Container(
  //                     width: 50.0,
  //                     margin: EdgeInsets.all(5.0),
  //                     padding: EdgeInsets.all(5.0),
  //                     decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(5.0),
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         "خیر",
  //                         style: TextStyle(
  //                           color: CBase().textPrimaryColor,
  //                           fontSize: CBase().getTextfontSizeByScreen(),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   onTap: () {
  //                     // ignore: deprecated_member_use
  //                     ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
  //                     // scaffold.currentState!.hideCurrentSnackBar();
  //                   },
  //                 )
  //               ],
  //             ),
  //             SizedBox(
  //               width: 10.0,
  //             ),
  //           ],
  //         )),
  //   );

  //   // ignore: deprecated_member_use
  //   ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  //   // scaffold.currentState!.showSnackBar(snackBar);
  //   Future.delayed(Duration(seconds: 3), () {
  //     // ignore: deprecated_member_use
  //     ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  //     // scaffold.currentState!.hideCurrentSnackBar();
  //   });
  // }

  // exitSnackBar() {
  //   Get.showSnackbar(GetSnackBar(
  //     titleText: Text(
  //       "خروج از برنامه",
  //       style: TextStyle(
  //         fontSize: CBase().getTextfontSizeByScreen(),
  //         fontWeight: FontWeight.bold,
  //         color: Colors.orangeAccent,
  //       ),
  //     ),
  //     messageText: Text(
  //       "آیا مایل به خروج از برنامه هستید ؟",
  //       style: TextStyle(fontSize: CBase().getTextfontSizeByScreen()),
  //     ),
  //     duration: Duration(seconds: 3),
  //     mainButton: Row(
  //       children: [
  //         InkWell(
  //           child: Container(
  //             width: 50.0,
  //             padding: EdgeInsets.all(5.0),
  //             margin: EdgeInsets.all(5.0),
  //             decoration: BoxDecoration(
  //               color: CBase().basePrimaryColor,
  //               borderRadius: BorderRadius.circular(5.0),
  //             ),
  //             child: Center(
  //               child: Text(
  //                 "بله",
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: CBase().getTextfontSizeByScreen(),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           onTap: () {
  //             LoginController loginController = Get.find();
  //             loginController.exitApp();

  //             Navigator.pushAndRemoveUntil(
  //                 Get.context!,
  //                 MaterialPageRoute(builder: (context) => LoginPage()),
  //                 (route) => false);
  //           },
  //         ),
  //         InkWell(
  //           child: Container(
  //             width: 50.0,
  //             margin: EdgeInsets.all(5.0),
  //             padding: EdgeInsets.all(5.0),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(5.0),
  //             ),
  //             child: Center(
  //               child: Text(
  //                 "خیر",
  //                 style: TextStyle(
  //                   color: CBase().textPrimaryColor,
  //                   fontSize: CBase().getTextfontSizeByScreen(),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           onTap: () {
  //             // ignore: deprecated_member_use
  //             Get.back();
  //           },
  //         )
  //       ],
  //     ),
  //   ));
  // }

  GETSnackBar(bool isSuccessful, String text) {
    Get.showSnackbar(GetBar(
      titleText: Text(
        isSuccessful ? "عملیات موفق" : "عملیات ناموفق",
        style: TextStyle(
          fontSize: CBase().getTextfontSizeByScreen(),
          fontWeight: FontWeight.bold,
          color: isSuccessful ? CBase().successColor : CBase().basePrimaryColor,
        ),
      ),
      messageText: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: CBase().getTextfontSizeByScreen(),
        ),
      ),
      duration: Duration(milliseconds: 1500),
      snackStyle: SnackStyle.GROUNDED,
    ));
  }
}
