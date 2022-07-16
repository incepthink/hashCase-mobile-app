import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final JWTStorage = const FlutterSecureStorage();
  final userStorage = const FlutterSecureStorage();
  final addressStorage = const FlutterSecureStorage();
}
