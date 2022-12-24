import 'package:flutter/material.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({
    required this.isSelected,
    required this.onTap,
    required this.title,
    Key? key,
  }) : super(key: key);
  final bool isSelected;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14),
        alignment: Alignment.center,
        decoration: _buildTabDecoration(isSelected
            ? Color(0XFF666666)
            : Color.fromARGB(255, 189, 184, 184)),
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  BoxDecoration _buildTabDecoration(Color color) {
    return BoxDecoration(color: color, borderRadius: BorderRadius.circular(10));
  }
}
