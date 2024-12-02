import 'package:flutter/material.dart';

class UtilFunctions {
  static navigateTo(BuildContext context, Widget widget) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }

  static goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
