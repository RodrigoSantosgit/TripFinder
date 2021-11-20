// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trips.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripsAdapter extends TypeAdapter<Trips> {
  @override
  final int typeId = 1;

  @override
  Trips read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trips(
      fields[0] as int,
      fields[1] as int,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Trips obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.distance)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.contentShort)
      ..writeByte(4)
      ..write(obj.contentFull)
      ..writeByte(5)
      ..write(obj.imageurl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
