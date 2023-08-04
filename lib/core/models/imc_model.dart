import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'imc_model.g.dart';

@HiveType(typeId: 0)
class IMCModel extends HiveObject {
  @HiveField(0)
  String id = UniqueKey().toString();

  @HiveField(1)
  String data = "${DateTime.now()}";

  @HiveField(2)
  double altura = 0.0;

  @HiveField(3)
  double peso = 0.0;

  @HiveField(4)
  double imc = 0.0;

  @HiveField(5)
  String classificacao = "";

  IMCModel();

  IMCModel.criar(this.altura, this.peso, this.imc, this.classificacao);

  String get dataFormatted => DateFormat("dd/MM/yyyy").format(
        DateTime.tryParse(data) ?? DateTime.now(),
      );

  DateTime get dataDate => DateTime.tryParse(data) ?? DateTime.now();
}
