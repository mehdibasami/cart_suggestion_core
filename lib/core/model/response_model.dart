import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponseModel<T> {
  bool isSuccess;
  String? statusCode;
  String message;
  dynamic data;

  ResponseModel({
    this.isSuccess = false,
    this.statusCode,
    this.message = "",
    this.data,
  });

  ResponseModel fromJson<T>(dynamic jsn) {
   statusCode = jsn["statusCode"].toString();
   data = jsn["data"];
   isSuccess = jsn["isSuccess"];
   message = jsn["message"].toString();

    return this;
  }

  showMessage() {
    Get.showSnackbar(GetSnackBar(
      titleText: Text(
       isSuccess ? "عملیات موفق" : "عملیات ناموفق",
        style: TextStyle(
          fontSize: CBase().getTextfontSizeByScreen(),
          fontWeight: FontWeight.bold,
          color:
             isSuccess ? CBase().successColor : CBase().basePrimaryColor,
        ),
      ),
      messageText: Text(
      message,
        style: TextStyle(
          color: Colors.white,
          fontSize: CBase().getTextfontSizeByScreen(),
        ),
      ),
      duration:const Duration(seconds: 2),
      snackStyle: SnackStyle.GROUNDED,
    ));
  }
}
