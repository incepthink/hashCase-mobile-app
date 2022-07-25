import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const userStorage = FlutterSecureStorage();
  static const addressStorage = FlutterSecureStorage();
  static const JWTStorage = FlutterSecureStorage();
}
