import 'package:flutter/material.dart';

class Responsive {
 static bool isMopile(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 420) {
      return true;
    }
    return false;
  }

 static bool isTablet(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 420) {
      return true;
    }
    return false;
  }
}
