import 'package:hive/hive.dart';

import '../../GlobalConstants.dart' as gc;
import '../NFT/NFT2.dart';
part 'UserData.g.dart';

@HiveType(typeId: gc.kUSERDATA)
class UserData extends HiveObject {
  @HiveField(0)
  String? token;

  @HiveField(1)
  String email;

  @HiveField(2)
  int id;

  @HiveField(3)
  String? walletAddress;

  @HiveField(4)
  String? passwordHash;

  @HiveField(5)
  int? shippingID;

  @HiveField(6)
  bool? admin;

  @HiveField(7)
  String? username;

  @HiveField(8)
  DateTime createdAt;

  @HiveField(9)
  DateTime updatedAt;

  @HiveField(10)
  List<NFT2> myNFTList;

  UserData({
    required this.token,
    required this.email,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.admin,
    this.passwordHash,
    this.shippingID,
    this.username,
    this.walletAddress,
    this.myNFTList = const [],
  });

  factory UserData.fromMap(Map data) {
    return UserData(
      token: data['token'] ?? '-',
      id: data['user_instance'] != null
          ? data['user_instance']['id'] ?? '-'
          : data['id'] ?? '-',
      walletAddress: data['user_instance'] != null
          ? data['user_instance']['wallet_address'] ?? '-'
          : data['wallet_address'] ?? '-',
      email: data['user_instance'] != null
          ? data['user_instance']['email'] ?? '-'
          : data['email'] ?? '-',
      passwordHash: data['user_instance'] != null
          ? data['user_instance']['password_hash'] ?? '-'
          : data['password_hash'] ?? '-',
      shippingID: data['user_instance'] != null
          ? data['user_instance']['shipping_id'] ?? -1
          : data['shipping_id'] ?? -1,
      admin: data['user_instance'] != null
          ? data['user_instance']['admin'] ?? false
          : data['admin'] ?? false,
      username: data['user_instance'] != null
          ? data['user_instance']['username'] ?? '-'
          : data['username'] ?? '-',
      createdAt: DateTime.parse(data['user_instance'] != null
          ? data['user_instance']['createdAt'] ?? '2000-01-01 00:00:01'
          : data['createdAt'] ?? '2000-01-01 00:00:01'),
      updatedAt: DateTime.parse(data['user_instance'] != null
          ? data['user_instance']['updatedAt'] ?? '2000-01-01 00:00:01'
          : data['updatedAt'] ?? '2000-01-01 00:00:01'),
    );
  }
  @override
  String toString() {
    return 'UserData{token: $token, email: $email, id: $id, walletAddress: $walletAddress, passwordHash: $passwordHash, shippingID: $shippingID, admin: $admin, username: $username, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
