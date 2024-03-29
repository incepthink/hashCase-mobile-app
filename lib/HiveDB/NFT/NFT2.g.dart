// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NFT2.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NFT2Adapter extends TypeAdapter<NFT2> {
  @override
  final int typeId = 1;

  @override
  NFT2 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NFT2(
      id: fields[0] as int,
      userID: fields[1] as int,
      nftID: fields[2] as int,
      createdAt: fields[4] as DateTime,
      updatedAt: fields[5] as DateTime,
      merchandise: fields[6] as Merchandise,
      number: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, NFT2 obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userID)
      ..writeByte(2)
      ..write(obj.nftID)
      ..writeByte(3)
      ..write(obj.number)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.merchandise);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NFT2Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
