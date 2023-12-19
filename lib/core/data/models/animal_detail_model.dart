import '../../../domain/entities/animal_detail_entity.dart';

class AnimalDetailModel extends AnimalDetailEntity {
  AnimalDetailModel(
      {required super.id,
      required super.modelId,
      required super.description,
      required super.classification,
      required super.conservation,
      required super.reproduction,
      required super.culturalFigure,
      required super.views});

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
      'views': views
    };
  }

  factory AnimalDetailModel.fromMap(Map<String, dynamic> map) {
    return AnimalDetailModel(
      id: map['id'] ?? '',
      modelId: map['modelId'] ?? '',
      description: map['description'] ?? '',
      classification: map['classification'] ?? '',
      conservation: map['conservation'] ?? '',
      reproduction: map['reproduction'] ?? '',
      culturalFigure: map['culturalFigure'] ?? '',
      views: map['views'] ?? 0,
    );
  }
}
