// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HcNFT.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HcNFTAdapter extends TypeAdapter<HcNFT> {
  @override
  final int typeId = 2;

  @override
  HcNFT read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HcNFT(
      id: fields[0] as int,
      contractAddress: fields[1] as String,
      name: fields[3] as String,
      description: fields[4] as String,
      blockchain: fields[5] as String,
      image: fields[6] as String,
      standard: fields[10] as String,
      createdAt: fields[11] as DateTime,
      updatedAt: fields[12] as DateTime,
      count: fields[2] as int?,
      featured: fields[7] as String?,
      sponsored: fields[8] as bool?,
      type: fields[9] as String?,
      websiteLink: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HcNFT obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.contractAddress)
      ..writeByte(2)
      ..write(obj.count)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.blockchain)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.featured)
      ..writeByte(8)
      ..write(obj.sponsored)
      ..writeByte(9)
      ..write(obj.type)
      ..writeByte(10)
      ..write(obj.standard)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.websiteLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HcNFTAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
