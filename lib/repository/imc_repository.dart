import 'package:calculadora_imc_flutter/models/imc_model.dart';

class IMCRepository {
  final List<IMCModel> _results = [];

  Future<void> add(IMCModel imc) async {
    await Future.delayed(const Duration(milliseconds: 100));

    _results.add(imc);
  }

  Future<void> edit(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _results.where((element) => element.id == id).first;
  }

  Future<void> remove(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _results.remove(_results.where((element) => element.id == id).first);
  }

  Future get() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _results;
  }

  static double calcularIMC(double peso, double altura) {
    altura = altura / 100;

    double valor = peso / (altura * altura);

    return double.parse(valor.toStringAsFixed(2));
  }

  static String classificacaoIMC(double imc) {
    if (imc < 16) {
      return "Magreza grave";
    } else if (imc >= 16 && imc < 17) {
      return "Magreza moderada";
    } else if (imc >= 17 && imc < 18.5) {
      return "Magreza leve";
    } else if (imc >= 18.5 && imc < 25) {
      return "Saudável";
    } else if (imc >= 25 && imc < 30) {
      return "Sobrepeso";
    } else if (imc >= 30 && imc < 35) {
      return "Obesidade grau I";
    } else if (imc >= 35 && imc < 40) {
      return "Obesidade grau II (severa)";
    } else {
      return "Obesidade grau III (mórbida)";
    }
  }
}
