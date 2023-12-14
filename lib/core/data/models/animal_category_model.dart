import '../../../domain/entities/animal_category_entity.dart';

class AnimalCategoryModel extends AnimalCategoryEntity {
  AnimalCategoryModel(
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

  factory AnimalCategoryModel.fromMap(Map<String, dynamic> map) {
    return AnimalCategoryModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      status: map['status'] ?? true,
    );
  }
}
