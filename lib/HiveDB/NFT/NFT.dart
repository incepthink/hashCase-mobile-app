import 'package:hive/hive.dart';

import '../../GlobalConstants.dart' as gc;
part 'NFT.g.dart';

@HiveType(typeId: gc.kNFT)
class NFT extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int tokenID;

  @HiveField(2)
  String name;

  @HiveField(3)
  String imageURL;

  @HiveField(4)
  String type;

  @HiveField(5)
  String openseaLink;

  @HiveField(6)
  int claimable;

  @HiveField(7)
  int collectionID;

  @HiveField(8)
  String collectionContractAddress;

  @HiveField(9)
  String collectionName;

  @HiveField(10)
  String collectionType;

  NFT({
    required this.id,
    required this.tokenID,
    required this.name,
    required this.imageURL,
    required this.type,
    required this.openseaLink,
    required this.claimable,
    required this.collectionID,
    required this.collectionContractAddress,
    required this.collectionName,
    required this.collectionType,
  });

  factory NFT.fromMap(Map data) {
    return NFT(
      id: data['id'] ?? -1,
      tokenID: data['token_id'] ?? -1,
      name: data['name'] ?? '-',
      imageURL: data['nft_image_url'] ?? '-',
      type: data['type'] ?? '-',
      openseaLink: data['opensea_link'] ?? '-',
      claimable: data['claimable'] ?? -1,
      collectionID: data['collection.id'] ?? -1,
      collectionContractAddress: data['collection.contract_address'] ?? '-',
      collectionName: data['collection.name'] ?? '-',
      collectionType: data['collection.type'] ?? '-',
    );
  }
}
