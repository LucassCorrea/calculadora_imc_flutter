// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

class IMCModel {
  String id = UniqueKey().toString();
  DateTime data = DateTime.now();
  double _altura;
  double _peso;
  double _imc;
  String _classificacao;

  IMCModel(this._altura, this._peso, this._imc, this._classificacao);

  double get altura => _altura;
  set altura(double altura) => _altura = altura;

  double get peso => _peso;
  set peso(double peso) => _peso = peso;

  double get imc => _imc;
  set imc(double imc) => _imc = imc;

  String get classificacao => _classificacao;
  set classificacao(String classificacao) => _classificacao = classificacao;
}
