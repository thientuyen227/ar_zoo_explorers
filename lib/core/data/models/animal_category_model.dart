import '../../../domain/entities/model_category_entity.dart';

class ModelCategoryModel extends ModelCategoryEntity {
  ModelCategoryModel(
      {required super.id,
      required super.name,
      required super.title,
      required super.imageUrl,
      required super.status});
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'imageUrl': imageUrl,
      'status': status
    };
  }

  factory ModelCategoryModel.fromMap(Map<String, dynamic> map) {
    return ModelCategoryModel(
      id: map['id'] ?? '',
      title: map['title'] ??
          {
            'en': '',
            'vi': '',
          },
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      status: map['status'] ?? true,
    );
  }
}
