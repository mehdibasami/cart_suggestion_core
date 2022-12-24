import 'package:flutter/material.dart';

class CustomRemoveDialog extends StatelessWidget {
  const CustomRemoveDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('آیا از حذف این مورد اطمینان دارید؟'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('خیر')),
        TextButton(
            onPressed: () {
              // onDelete();
              Navigator.pop(context);
            },
            child: Text('بله')),
      ],
    );
  }
}

Widget _alertDeleteDialog(BuildContext context,
    {required Function() onDelete}) {
  return AlertDialog(
    title: Text('آیا از حذف این مورد اطمینان دارید؟'),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('خیر')),
      TextButton(
          onPressed: () {
            onDelete();
            Navigator.pop(context);
          },
          child: Text('بله')),
    ],
  );
}
