// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DBModelAdapter extends TypeAdapter<DBModel> {
  @override
  final int typeId = 0;

  @override
  DBModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DBModel(
      path: fields[0] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, DBModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DBModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
