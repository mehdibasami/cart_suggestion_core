import 'package:flutter/material.dart';

class FullCheckBox extends StatelessWidget {
  final bool value;
  final Function? onChanged;

  const FullCheckBox({required this.value, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged!=null?() {
        onChanged!(value);
      }:null,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 15.0,
        height: 15.0,
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.width),
            border: Border.all(width: 1, color: Color(0xffcccccc)),
            color: value ? Color(0xffff0000) : Color(0xffcccccc)),
      ),
    );
  }
}
