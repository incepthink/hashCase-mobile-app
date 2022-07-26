import 'package:hash_case/HiveDB/NFT/Merchandise.dart';
import 'package:hive/hive.dart';

import '../../GlobalConstants.dart' as gc;
part 'NFT2.g.dart';

@HiveType(typeId: gc.kNFT)
class NFT2 extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int userID;

  @HiveField(2)
  int nftID;

  @HiveField(3)
  int? number;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime updatedAt;

  @HiveField(6)
  Merchandise merchandise;

  NFT2({
    required this.id,
    required this.userID,
    required this.nftID,
    required this.createdAt,
    required this.updatedAt,
    required this.merchandise,
    this.number,
  });

  factory NFT2.fromMap(Map data) {
    return NFT2(
      id: data['id'] ?? -1,
      userID: data['user_id'] ?? -1,
      nftID: data['nft_id'] ?? -1,
      createdAt: DateTime.parse(data['createdAt'] ?? '2000-01-01 00:00:01'),
      updatedAt: DateTime.parse(data['updatedAt'] ?? '2000-01-01 00:00:01'),
      merchandise: Merchandise.fromMap(data['merchandise']),
      number: data['number'] ?? -1,
    );
  }

  @override
  String toString() {
    return 'NFT2{id: $id, userID: $userID, nftID: $nftID, number: $number, createdAt: $createdAt, updatedAt: $updatedAt, merchandise: $merchandise}';
  }
}
