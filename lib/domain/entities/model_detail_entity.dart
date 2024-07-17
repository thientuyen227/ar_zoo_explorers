import 'dart:convert';

import 'package:get/get.dart';

class ModelDetailEntity {
  String id; // ID
  String modelId; // ID model của animal
  Map<String, String> description; // Mô tả
  Map<String, String> classification; // Phân loại sinh học
  Map<String, String> conservation; // Tình trạng bảo tồn
  Map<String, String> reproduction; // Sinh sản
  Map<String, String> culturalFigure; // Hình tượng trong văn hóa
  Map<String, String> preservation; // Bảo quản
  Map<String, String> culturalSignificance; // Giá trị văn hóa
  Map<String, String> maintenance; // Bảo trì
  Map<String, String> manufacturing; // Sản xuất
  Map<String, String> educationalValue; // Giá trị giáo dục
  int views; // Lượt xem

  ModelDetailEntity(
      {required this.id,
      required this.modelId,
      required this.description,
      required this.classification,
      required this.conservation,
      required this.reproduction,
      required this.culturalFigure,
      required this.preservation,
      required this.culturalSignificance,
      required this.maintenance,
      required this.manufacturing,
      required this.educationalValue,
      required this.views});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'modelId': modelId,
      'description': description,
      'classification': classification,
      'conservation': conservation,
      'reproduction': reproduction,
      'culturalFigure': culturalFigure,
      'preservation': preservation,
      'culturalSignificance': culturalSignificance,
      'maintenance': maintenance,
      'manufacturing': manufacturing,
      'educationalValue': educationalValue,
      'views': views
    };
  }

  factory ModelDetailEntity.fromMap(Map<String, dynamic> map) {
    return ModelDetailEntity(
      id: map['id'] as String,
      modelId: map['modelId'] as String,
      description: Map<String, String>.from((map['description'] ?? "")),
      classification: Map<String, String>.from((map['classification'] ?? "")),
      conservation: Map<String, String>.from((map['conservation'] ?? "")),
      reproduction: Map<String, String>.from((map['reproduction'] ?? "")),
      culturalFigure: Map<String, String>.from((map['culturalFigure'] ?? "")),
      preservation: Map<String, String>.from((map['preservation'] ?? "")),
      culturalSignificance:
          Map<String, String>.from((map['culturalSignificance'] ?? "")),
      maintenance: Map<String, String>.from((map['maintenance'] ?? "")),
      manufacturing: Map<String, String>.from((map['manufacturing'] ?? "")),
      educationalValue:
          Map<String, String>.from((map['educationalValue'] ?? "")),
      views: map['views'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelDetailEntity.fromJson(String source) =>
      ModelDetailEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension ModelDetailEntityExt on ModelDetailEntity {
  String _getLocalizedValue(Map<String, String> data) {
    final languageCode = Get.locale?.languageCode;
    return data.containsKey(languageCode)
        ? data[languageCode]!
        : data.values.firstOrNull ?? "";
  }

  String get descriptionsLocalize => _getLocalizedValue(description);
  String get classificationsLocalize => _getLocalizedValue(classification);
  String get conservationsLocalize => _getLocalizedValue(conservation);
  String get reproductionsLocalize => _getLocalizedValue(reproduction);
  String get culturalFiguresLocalize => _getLocalizedValue(culturalFigure);
  String get preservationsLocalize => _getLocalizedValue(preservation);
  String get culturalSignificancesLocalize =>
      _getLocalizedValue(culturalSignificance);
  String get maintenancesLocalize => _getLocalizedValue(maintenance);
  String get manufacturingsLocalize => _getLocalizedValue(manufacturing);
  String get educationalValuesLocalize => _getLocalizedValue(educationalValue);
}
