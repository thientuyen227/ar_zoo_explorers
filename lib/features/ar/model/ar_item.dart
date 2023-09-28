import 'package:ar_zoo_explorers/features/ar/model/ar_type.dart';

class ARItem {
  ARType type;
  String title;
  String? icon;
  String? link;
  String name;

  ARItem(
      {required this.type,
      required this.title,
      this.icon,
      this.link,
      required this.name});
}
