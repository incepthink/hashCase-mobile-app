import 'package:hash_case/HiveDB/NFT/Merchandise.dart';
import 'package:hive/hive.dart';

import '../../GlobalConstants.dart' as gc;
part 'NFT.g.dart';

@HiveType(typeId: gc.kNFT)
class NFT extends HiveObject {
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

  @HiveField(7)
  bool fromWallet;

  NFT({
    required this.id,
    required this.userID,
    required this.nftID,
    required this.createdAt,
    required this.updatedAt,
    required this.merchandise,
    required this.fromWallet,
    this.number,
  });

  factory NFT.fromEmail(Map data) {
    return NFT(
      id: data['id'] ?? -1,
      userID: data['user_id'] ?? -1,
      nftID: data['nft_id'] ?? -1,
      createdAt: DateTime.parse(data['createdAt'] ?? '2000-01-01 00:00:01'),
      updatedAt: DateTime.parse(data['updatedAt'] ?? '2000-01-01 00:00:01'),
      merchandise: Merchandise.fromMap(data['merchandise']),
      number: data['number'] ?? -1,
      fromWallet: false,
    );
  }

  factory NFT.fromWallet(Map data) {
    return NFT(
      merchandise: Merchandise.fromMap(data),
      nftID: -1,
      id: -1,
      updatedAt: DateTime.parse('2000-01-01 00:00:01'),
      userID: -1,
      createdAt: DateTime.parse('2000-01-01 00:00:01'),
      number: -1,
      fromWallet: true,
    );
  }

  @override
  String toString() {
    return 'NFT2{id: $id, userID: $userID, nftID: $nftID, number: $number, createdAt: $createdAt, updatedAt: $updatedAt, merchandise: $merchandise}';
  }
}
