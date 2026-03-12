import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomFlutterToast {
  static toast({required String content}) {
    return Fluttertoast.showToast(
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      msg: content,
      backgroundColor: Colors.green,
    );
  }
}
