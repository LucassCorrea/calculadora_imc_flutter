import 'package:calculadora_imc_flutter/core/utils/utils.dart';

class FormValidator {
  static String? errorText(String? text) {
    double value = 0.0;

    if (text == null || text.isEmpty) {
      return "Campo vázio";
    } else {
      value = Utils.toDouble(text);
    }

    if (value <= 0) {
      return "Valor inválido";
    }

    return null;
  }
}
