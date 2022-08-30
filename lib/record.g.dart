// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecordAdapter extends TypeAdapter<Record> {
  @override
  final int typeId = 1;

  @override
  Record read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Record(
      tutorialLearned: fields[0] as bool,
    )
      ..smallPressureThreshold = fields[1] as double
      ..bigPressureThreshold = fields[2] as double;
  }

  @override
  void write(BinaryWriter writer, Record obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tutorialLearned)
      ..writeByte(1)
      ..write(obj.smallPressureThreshold)
      ..writeByte(2)
      ..write(obj.bigPressureThreshold);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
