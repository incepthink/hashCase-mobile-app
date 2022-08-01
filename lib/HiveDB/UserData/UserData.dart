import 'package:hive/hive.dart';

import '../../GlobalConstants.dart' as gc;
import '../NFT/NFT.dart';
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
  List<NFT> myNFTList;

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

  factory UserData.fromMetaMask(Map data) {
    return UserData(
      token: data['token'] ?? '-',
      id: data['id'] ?? '-',
      walletAddress: data['wallet_address'] ?? '-',
      email: data['email'] ?? '-',
      passwordHash: data['password_hash'] ?? '-',
      shippingID: data['shipping_id'] ?? -1,
      admin: data['admin'] ?? false,
      username: data['username'] ?? '-',
      createdAt: DateTime.parse(data['createdAt'] ?? '2000-01-01 00:00:01'),
      updatedAt: DateTime.parse(data['updatedAt'] ?? '2000-01-01 00:00:01'),
    );
  }

  factory UserData.fromEmail(Map data) {
    final userInstance = data['user_instance'];
    return UserData(
      token: data['token'] ?? '-',
      id: userInstance['id'] ?? '-',
      walletAddress: userInstance['wallet_address'] ?? '-',
      email: userInstance['email'] ?? '-',
      passwordHash: userInstance['password_hash'] ?? '-',
      shippingID: userInstance['shipping_id'] ?? -1,
      admin: userInstance['admin'] ?? false,
      username: userInstance['username'] ?? '-',
      createdAt:
          DateTime.parse(userInstance['createdAt'] ?? '2000-01-01 00:00:01'),
      updatedAt:
          DateTime.parse(userInstance['updatedAt'] ?? '2000-01-01 00:00:01'),
    );
  }
  @override
  String toString() {
    return 'UserData{token: $token, email: $email, id: $id, walletAddress: $walletAddress, passwordHash: $passwordHash, shippingID: $shippingID, admin: $admin, username: $username, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
