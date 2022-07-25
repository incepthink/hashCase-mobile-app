// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NFT.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NFTAdapter extends TypeAdapter<NFT> {
  @override
  final int typeId = 1;

  @override
  NFT read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NFT(
      id: fields[0] as int,
      tokenID: fields[1] as int,
      name: fields[2] as String,
      imageURL: fields[3] as String,
      type: fields[4] as String,
      openseaLink: fields[5] as String,
      claimable: fields[6] as int,
      collectionID: fields[7] as int,
      collectionContractAddress: fields[8] as String,
      collectionName: fields[9] as String,
      collectionType: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NFT obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tokenID)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.imageURL)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.openseaLink)
      ..writeByte(6)
      ..write(obj.claimable)
      ..writeByte(7)
      ..write(obj.collectionID)
      ..writeByte(8)
      ..write(obj.collectionContractAddress)
      ..writeByte(9)
      ..write(obj.collectionName)
      ..writeByte(10)
      ..write(obj.collectionType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NFTAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
