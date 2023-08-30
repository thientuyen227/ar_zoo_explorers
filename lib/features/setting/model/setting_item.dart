import 'setting_type.dart';

class SettingItem {
  SettingType type;
  String title;
  String? icon;

  SettingItem({
    required this.type,
    required this.title,
    this.icon,
  });
}
