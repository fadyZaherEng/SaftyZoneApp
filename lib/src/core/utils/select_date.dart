import 'dart:io';
import 'package:flutter/material.dart';
import 'package:safety_zone/src/core/utils/android_date_picker.dart';
import 'package:safety_zone/src/core/utils/ios_date_picker.dart';

Future<void> selectDate(
  BuildContext context,
  bool isFrom,
  void Function(DateTime) onDateSelected,
) async {
  if (Platform.isAndroid) {
    androidDatePicker(
      context: context,
      firstDate: DateTime(2000),
      selectedDate: DateTime.now(),
      onSelectDate: (picked) {
        if (picked != null) onDateSelected(picked);
      },
    );
  } else {
    DateTime? picked;
    iosDatePicker(
      context: context,
      selectedDate: DateTime.now(),
      onChange: (date) => picked = date,
      onCancel: () => Navigator.pop(context),
      onDone: () {
        if (picked != null) onDateSelected(picked!);
      },
    );
  }
}
