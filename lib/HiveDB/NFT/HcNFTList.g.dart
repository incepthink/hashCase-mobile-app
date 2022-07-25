// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HcNFTList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HcNFTListAdapter extends TypeAdapter<HcNFTList> {
  @override
  final int typeId = 3;

  @override
  HcNFTList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HcNFTList(
      hcNFTList: (fields[0] as List).cast<HcNFT>(),
    );
  }

  @override
  void write(BinaryWriter writer, HcNFTList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.hcNFTList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HcNFTListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
