import 'package:get_storage/get_storage.dart';

class StorageHelper {
  static final GetStorage _storage = GetStorage('Active 9');

  static Future<void> setEmail(String value) async =>
      _storage.write(StorageKeys.email, value);
  static String? getEmail() => _storage.read(StorageKeys.email);

  static Future<void> setPassword(String value) async =>
      _storage.write(StorageKeys.password, value);
  static String? getPassword() => _storage.read(StorageKeys.password);

  static Future<void> setLanguageCode(String value) async =>
      _storage.write(StorageKeys.languageCode, value);
  static String? getLanguageCode() => _storage.read(StorageKeys.languageCode);

  static void erase() {
    _storage.erase();
  }
}

class StorageKeys {
  static const String email = "accessToken";
  static const String password = "refreshToken";
  static const String languageCode = "languageCode";
}
