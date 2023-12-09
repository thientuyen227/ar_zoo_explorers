import 'package:ar_zoo_explorers/domain/entities/animal_entity.dart';

class AnimalModel extends AnimalEntity {
  AnimalModel(
      {required super.id,
      required super.title,
      required super.icon,
      required super.link,
      required super.name});
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'icon': icon, 'link': link, 'name': name};
  }

  factory AnimalModel.fromMap(Map<String, dynamic> map) {
    return AnimalModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      icon: map['icon'] ?? '',
      link: map['link'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
