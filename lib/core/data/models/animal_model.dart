import 'package:ar_zoo_explorers/domain/entities/animal_entity.dart';

class AnimalModel extends AnimalEntity {
  AnimalModel(
      {required super.id,
      required super.title,
      required super.icon,
      required super.type,
      required super.name,
      required super.categoryId,
      required super.status});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'type': type,
      'name': name,
      'categoryId': categoryId,
      'status': status
    };
  }

  factory AnimalModel.fromMap(Map<String, dynamic> map) {
    return AnimalModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      icon: map['icon'] ?? '',
      type: map['type'] ?? '',
      name: map['name'] ?? '',
      categoryId: map['categoryId'] ?? '',
      status: true,
    );
  }
}
