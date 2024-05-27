// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';

class LearningCategoryEntity {
  final String id;
  final String imagePath;
  final Map<String, String> name;

  LearningCategoryEntity(
      {required this.id, required this.imagePath, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imagePath': imagePath,
      'name': name,
    };
  }

  factory LearningCategoryEntity.fromMap(Map<String, dynamic> map) {
    return LearningCategoryEntity(
      id: map['id'] as String,
      imagePath: map['imagePath'] as String,
      name: Map<String, String>.from((map['name'] ?? "")),
    );
  }

  String toJson() => json.encode(toMap());

  factory LearningCategoryEntity.fromJson(String source) =>
      LearningCategoryEntity.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

extension LearningCategoryEntityExt on LearningCategoryEntity {
  String _getLocalizedValue(Map<String, String> data) {
    final languageCode = Get.locale?.languageCode;
    return data.containsKey(languageCode)
        ? data[languageCode]!
        : data.values.firstOrNull ?? "";
  }

  String get nameLocalize => _getLocalizedValue(name);
}
