import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class DateMonthPiker {
  static Future<DateTime?> getDatePicker({
    required BuildContext context,
    required DateTime initialDate,
  }) async {
    return await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      initialDate: initialDate,
    );
  }

  static Future<DateTime?> getMonthPicker({
    required BuildContext context,
    required DateTime initialDate,
  }) async {
    return await showMonthPicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      initialDate: initialDate,
    );
  }
}
