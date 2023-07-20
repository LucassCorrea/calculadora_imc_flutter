import 'package:flutter/material.dart';

class MessengerSnackBar {
  static mensseger(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }
}
