import 'package:calculadora_imc_flutter/utils/utils.dart';
import 'package:flutter/material.dart';

class FormValidator {
  static String? errorText(TextEditingController controller) {
    double value = 0.0;

    final text = controller.value.text.trim();

    if (text.isEmpty) {
      return "Campo vázio";
    } else {
      value = Utils.toDouble(controller);
    }

    if (value <= 0) {
      return "Valor inválido";
    }

    return null;
  }
}
