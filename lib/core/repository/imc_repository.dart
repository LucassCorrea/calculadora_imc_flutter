import 'package:calculadora_imc_flutter/core/models/imc_model.dart';
import 'package:hive/hive.dart';

class IMCRepository {
  static late Box _box;

  IMCRepository._criar();

  static Future<IMCRepository> load() async {
    if (Hive.isBoxOpen('imc')) {
      _box = Hive.box<IMCModel>('imc');
    } else {
      _box = await Hive.openBox<IMCModel>('imc');
    }
    return IMCRepository._criar();
  }

  Future<void> add(IMCModel imc) async {
    await _box.add(imc);
  }

  Future<void> edit(IMCModel imc) async {
    await imc.save();
  }

  Future<void> remove(IMCModel imc) async {
    await imc.delete();
  }

  Future<void> removeAll() async {
    await _box.clear();
  }

  List<IMCModel> get() {
    return _box.values.cast<IMCModel>().toList();
  }

  static double calcularIMC(double peso, double altura) {
    altura = altura / 100;

    double valor = peso / (altura * altura);

    return double.parse(valor.toStringAsFixed(2));
  }

  static String classificacaoIMC(double imc) {
    if (imc >= 0 && imc < 16) {
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
    } else if (imc >= 40) {
      return "Obesidade grau III (mórbida)";
    } else {
      return "Não classificado";
    }
  }
}
