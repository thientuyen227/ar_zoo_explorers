import '../../../domain/entities/model_detail_entity.dart';

class ModelDetailModel extends ModelDetailEntity {
  ModelDetailModel(
      {required super.id,
      required super.modelId,
      required super.description,
      required super.classification,
      required super.conservation,
      required super.reproduction,
      required super.culturalFigure,
      required super.views,
      required super.preservation,
      required super.culturalSignificance,
      required super.maintenance,
      required super.manufacturing,
      required super.educationalValue});

  @override
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

  factory ModelDetailModel.fromMap(Map<String, dynamic> map) {
    return ModelDetailModel(
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
      views: map['status'] as int,
    );
  }
}
