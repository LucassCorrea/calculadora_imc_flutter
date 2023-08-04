import 'package:shared_preferences/shared_preferences.dart';

enum Chaves {
  altura,
  isFixedAltura,
}

class SharedRepository {
  Future<void> setIsFixedAltura(bool value) async {
    await _setBool(Chaves.isFixedAltura.toString(), value);
  }

  Future<bool> getIsFixedAltura() async {
    return _getBool(Chaves.isFixedAltura.toString());
  }

  Future<void> setAltura(double value) async {
    await _setDouble(Chaves.altura.toString(), value);
  }

  Future<double> getAltura() async {
    return _getDouble(Chaves.altura.toString());
  }

  Future<void> _setDouble(String chave, double value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setDouble(chave, value);
  }

  Future<double> _getDouble(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(key) ?? 0;
  }

  Future<void> _setBool(String key, bool value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setBool(key, value);
  }

  Future<bool> _getBool(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(key) ?? false;
  }
}
