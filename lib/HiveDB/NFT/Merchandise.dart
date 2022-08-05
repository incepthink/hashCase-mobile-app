import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import '../../GlobalConstants.dart';
part 'Merchandise.g.dart';

@HiveType(typeId: kMerchandise)
class Merchandise extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  int tokenID;
  @HiveField(2)
  bool claimable;
  @HiveField(3)
  String imageURL;
  @HiveField(4)
  String openseaLink;
  @HiveField(5)
  String description;
  @HiveField(6)
  String name;
  @HiveField(7)
  String type;
  @HiveField(8)
  DateTime createdAt;
  @HiveField(9)
  DateTime updatedAt;

  Merchandise({
    required this.id,
    required this.tokenID,
    required this.claimable,
    required this.imageURL,
    required this.openseaLink,
    required this.description,
    required this.name,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Merchandise.fromMap(Map data) {
    return Merchandise(
      id: data['id'] ?? -1,
      tokenID: data['token_id'] ?? -1,
      claimable: data['claimable'] != null
          ? data['claimable'].runtimeType == int
              ? data['claimable'] > 0
                  ? true
                  : false
              : data['claimable']
          : false,
      imageURL: data['nft_image_url'] ?? '-',
      openseaLink: data['opensea_link'] ?? '-',
      description: data['description'] ?? '-',
      name: data['name'] ?? '-',
      type: data['type'] ?? '-',
      createdAt: DateTime.parse(data['createdAt'] ?? '2000-01-01 00:00:01'),
      updatedAt: DateTime.parse(data['updatedAt'] ?? '2000-01-01 00:00:01'),
    );
  }

  @override
  String toString() {
    return 'Merchandise{id: $id, tokenID: $tokenID, claimable: $claimable, imageURL: $imageURL, openseaLink: $openseaLink, description: $description, name: $name, type: $type, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
