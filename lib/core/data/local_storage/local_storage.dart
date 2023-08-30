import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

abstract class LocalStorage {
  Future<void> init();
  int get numMessagePerDay;
  void increaseNumMessagePerDay();
}

@Singleton(as: LocalStorage)
class LocalStorageImpl extends LocalStorage {
  Box? _box;

  @override
  Future<void> init() async {
    await Hive.initFlutter((await getApplicationSupportDirectory()).path);
    _box = await Hive.openBox("mainApp", encryptionCipher: HiveAesCipher("newb@ppsXXXXXXXXXXXXXXXXXXXXXXXX".codeUnits));
  }

  @override
  void increaseNumMessagePerDay() {
    int num = numMessagePerDay;
    _box?.put(DateFormat.yMd().format(DateTime.now()), num + 1);
  }

  @override
  int get numMessagePerDay => _box?.get(DateFormat.yMd().format(DateTime.now()), defaultValue: 0) ?? 0;
}
