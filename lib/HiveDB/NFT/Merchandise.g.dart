// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Merchandise.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MerchandiseAdapter extends TypeAdapter<Merchandise> {
  @override
  final int typeId = 4;

  @override
  Merchandise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Merchandise(
      id: fields[0] as int,
      tokenID: fields[1] as int,
      claimable: fields[2] as bool,
      imageURL: fields[3] as String,
      openseaLink: fields[4] as String,
      description: fields[5] as String,
      name: fields[6] as String,
      type: fields[7] as String,
      createdAt: fields[8] as DateTime,
      updatedAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Merchandise obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tokenID)
      ..writeByte(2)
      ..write(obj.claimable)
      ..writeByte(3)
      ..write(obj.imageURL)
      ..writeByte(4)
      ..write(obj.openseaLink)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchandiseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
