import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({Key? key,required this.onPressedOk,required this.onPressedCancel
    ,required this.title,required this.okText,required this.cancelText}) : super(key: key);
  final Function onPressedOk;
  final Function onPressedCancel;
  final String okText;
  final String cancelText;
  final String title;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                onPressedOk();
              },
              child:  Text(okText)),
          TextButton(
              onPressed: () {
                onPressedCancel();
              },
              child:Text(cancelText)),
        ],
        actionsAlignment: MainAxisAlignment.spaceBetween,
        title:  Text(
          title,
        ));
  }
}
