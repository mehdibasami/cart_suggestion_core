import 'package:cart_suggestion_core/core/values/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:persian_number_utility/persian_number_utility.dart';

class ShowTimeAndDateWidget extends StatelessWidget {
  ShowTimeAndDateWidget({Key? key, this.date}) : super(key: key);
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          '${date?.toPersianDateStr() ?? ' -- -- --'}',
          style: CustomTypography.title16w500h20,
        ),
        SvgPicture.asset('assets/images/date_icon.svg'),
        Text(
          date == null
              ? '-- : --'
              : '${intl.DateFormat('hh:mm a').format(date!).toPersianDigit()}',
          style: CustomTypography.title16w500h20,
          textDirection: TextDirection.ltr,
        ),
        SvgPicture.asset('assets/images/clock_icon.svg'),
      ],
    );
  }
}
