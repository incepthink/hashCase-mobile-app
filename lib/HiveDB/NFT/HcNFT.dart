import 'package:hive/hive.dart';

import '../../GlobalConstants.dart' as gc;
part 'HcNFT.g.dart';

@HiveType(typeId: gc.kHcNFT)
class HcNFT extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String contractAddress;

  @HiveField(2)
  int? count;

  @HiveField(3)
  String name;

  @HiveField(4)
  String description;

  @HiveField(5)
  String blockchain;

  @HiveField(6)
  String image;

  @HiveField(7)
  String? featured;

  @HiveField(8)
  bool? sponsored;

  @HiveField(9)
  String? type;

  @HiveField(10)
  String standard;

  @HiveField(11)
  DateTime createdAt;

  @HiveField(12)
  DateTime updatedAt;

  @HiveField(13)
  String? websiteLink;

  HcNFT({
    required this.id,
    required this.contractAddress,
    required this.name,
    required this.description,
    required this.blockchain,
    required this.image,
    required this.standard,
    required this.createdAt,
    required this.updatedAt,
    this.count,
    this.featured,
    this.sponsored,
    this.type,
    this.websiteLink,
  });

  factory HcNFT.fromMap(Map data) {
    return HcNFT(
      id: data['id'] ?? -1,
      contractAddress: data['contract_address'] ?? '-',
      websiteLink: data['website_link'] ?? '-',
      name: data['name'] ?? '-',
      description: data['description'] ?? '-',
      blockchain: data['blockchain'] ?? '-',
      image: data['image'] ?? '-',
      standard: data['standard'] ?? '-',
      createdAt: DateTime.parse(data['createdAt'] ?? '2000-01-01 00:00:01'),
      updatedAt: DateTime.parse(data['updatedAt'] ?? '2000-01-01 00:00:01'),
      count: data['count'] ?? -1,
      featured: data['featured'] ?? '-',
      sponsored: data['sponsor'] ?? false,
      type: data['type'] ?? '-',
    );
  }

  @override
  String toString() {
    return 'HcNFT{id: $id, contractAddress: $contractAddress, count: $count, name: $name, description: $description, blockchain: $blockchain, image: $image, featured: $featured, sponsored: $sponsored, type: $type, standard: $standard, createdAt: $createdAt, updatedAt: $updatedAt, websiteLink: $websiteLink}';
  }
}
