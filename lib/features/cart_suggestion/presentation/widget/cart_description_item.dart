import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemDescription extends StatelessWidget {
  CartItemDescription({
    Key? key,
    required this.brandName,
    required this.countryName,
    required this.vehicle,
    this.switchBtn,
    required this.productName,
    required this.cashPrice,
    required this.creditPrice,
    required this.productVirtualQTY,
  }) : super(key: key);
  final String countryName;
  final String vehicle;
  final String brandName;
  final String productName;
  final String cashPrice;
  final String creditPrice;
  final int productVirtualQTY;
  final Widget? switchBtn;
  @override
  Widget build(BuildContext context) {
    mainText(String text) => Text(
          text,
          maxLines: 2,
          style: TextStyle(
            fontSize: CBase().dinawinWidth(context) / 35,
            color: CBase().dinawinDarkGrey,
            fontWeight: FontWeight.bold,
          ),
        );
    return Container(
      // color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*----- brand name
          Text(
            brandName,
            style: TextStyle(
              color: CBase().dinawinDarkGrey.withOpacity(0.5),
              fontSize: CBase().dinawinWidth(context) / 40,
            ),
          ),

          //*----- product name
          mainText(productName),
          Spacer(),
          Text(
            vehicle,
            style: TextStyle(
              color: CBase().dinawinDarkGrey.withOpacity(0.5),
              fontSize: 10,
            ),
          ),
          Text(
            countryName,
            style: TextStyle(
              color: CBase().dinawinDarkGrey.withOpacity(0.5),
              fontSize: 10,
            ),
          ),
          // Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'نقدی:',
                        style: TextStyle(
                          color: CBase().dinawinDarkGrey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 5),
                      mainText(cashPrice),
                      SizedBox(width: 5),
                      Text(
                        'ریال'.tr,
                        style: TextStyle(
                          color: CBase().dinawinDarkGrey.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'اعتباری:',
                        style: TextStyle(
                          color: CBase().dinawinDarkGrey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 5),
                      mainText(creditPrice),
                      SizedBox(width: 5),
                      Text(
                        'ریال'.tr,
                        style: TextStyle(
                          color: CBase().dinawinDarkGrey.withOpacity(0.5),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '$productVirtualQTY عدد',
                      style: TextStyle(
                        color: CBase().dinawinDarkGrey,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                  if (switchBtn != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: switchBtn,
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
