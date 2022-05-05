// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudmodelAdapter extends TypeAdapter<Stud_model> {
  @override
  final int typeId = 1;

  @override
  Stud_model read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stud_model(
      age: fields[2] as String,
      regnum: fields[3] as String,
      class1: fields[4] as String,
      name: fields[1] as String,
      img: fields[5] as String,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Stud_model obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.regnum)
      ..writeByte(4)
      ..write(obj.class1)
      ..writeByte(5)
      ..write(obj.img);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
