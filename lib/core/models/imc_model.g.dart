// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IMCModelAdapter extends TypeAdapter<IMCModel> {
  @override
  final int typeId = 0;

  @override
  IMCModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IMCModel()
      ..id = fields[0] as String
      ..data = fields[1] as String
      ..altura = fields[2] as double
      ..peso = fields[3] as double
      ..imc = fields[4] as double
      ..classificacao = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, IMCModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.altura)
      ..writeByte(3)
      ..write(obj.peso)
      ..writeByte(4)
      ..write(obj.imc)
      ..writeByte(5)
      ..write(obj.classificacao);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IMCModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
