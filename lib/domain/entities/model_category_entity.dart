import 'dart:convert';

import 'package:get/get.dart';

class ModelCategoryEntity {
  String id;
  String name;
  Map<String, String> title;
  String imageUrl;
  bool status;

  ModelCategoryEntity(
      {required this.id,
      required this.name,
      required this.title,
      required this.imageUrl,
      required this.status});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'imageUrl': imageUrl,
      'status': status
    };
  }

  factory ModelCategoryEntity.fromMap(Map<String, dynamic> map) {
    return ModelCategoryEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      // phoneticTranscription: map['phoneticTranscription'] != null
      //     ? map['phoneticTranscription'] as String
      //     : null,
      title: Map<String, String>.from((map['title'] ?? "")),
      status: map['status'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelCategoryEntity.fromJson(String source) =>
      ModelCategoryEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension ModelCategoryEntityExt on ModelCategoryEntity {
  String _getLocalizedValue(Map<String, String> data) {
    final languageCode = Get.locale?.languageCode;
    return data.containsKey(languageCode)
        ? data[languageCode]!
        : data.values.firstOrNull ?? "";
  }

  String get titlesLocalize => _getLocalizedValue(title);
}
