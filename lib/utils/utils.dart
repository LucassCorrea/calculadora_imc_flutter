import 'package:flutter/material.dart';

class Utils {
  static double toDouble(TextEditingController controller) {
    String text = controller.value.text.trim();

    try {
      return double.parse(text);
    } catch (e) {
      return 0.0;
    }
  }
}
