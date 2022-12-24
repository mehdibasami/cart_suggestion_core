import 'package:cart_suggestion_core/core/values/base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  SecondAppBar({
    required this.title,
    this.onWillPop,
    Key? key,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  State<SecondAppBar> createState() => _SecondAppBarState();
  @override
  final Size preferredSize;
  final bool Function()? onWillPop;
}

class _SecondAppBarState extends State<SecondAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: CBase().dinawinDarkGrey),
      title: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onWillPop != null) {
                bool pop = widget.onWillPop!();
                if (pop) navigator?.pop();
              } else {
                navigator?.pop();
              }
            },
            child: SizedBox(
              width: CBase().dinawinWidth(context) / 9,
              height: CBase().dinawinWidth(context) / 9,
              child: Center(child: Icon(Icons.arrow_back_ios, size: 20)),
            ),
          ),
          Expanded(
            child: Text(
              widget.title,
              // overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: true,
              style: TextStyle(
                color: CBase().dinawinDarkGrey,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
