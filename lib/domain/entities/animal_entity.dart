import 'dart:convert';

import 'package:get/get.dart';

class AnimalEntity {
  String id;
  Map<String, String> titles;
  String icon;
  String type;
  String name;
  String categoryId;
  bool status;

  AnimalEntity(
      {required this.id,
      required this.titles,
      required this.icon,
      required this.type,
      required this.name,
      required this.categoryId,
      required this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titles': titles,
      'icon': icon,
      'type': type,
      'name': name,
      'categoryId': categoryId,
      'status': status,
    };
  }

  factory AnimalEntity.fromMap(Map<String, dynamic> map) {
    return AnimalEntity(
      id: map['id'] as String,
      categoryId: map['categoryId'] as String,
      icon: map['icon'] as String,
      type: map['type'] as String,
      name: map['name'] as String,
      titles: Map<String, String>.from((map['titles'] ?? "")),
      status: map['status'] as bool,
    );
  }
  String toJson() => json.encode(toMap());

  factory AnimalEntity.fromJson(String source) =>
      AnimalEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension AnimalEntityExt on AnimalEntity {
  String _getLocalizedValue(Map<String, String> data) {
    final languageCode = Get.locale?.languageCode;
    return data.containsKey(languageCode)
        ? data[languageCode]!
        : data.values.firstOrNull ?? "";
  }

  String get titlesLocalize => _getLocalizedValue(titles);
}
