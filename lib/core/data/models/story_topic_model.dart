import 'package:ar_zoo_explorers/domain/entities/story_topic_entity.dart';

class StoryTopicModel extends StoryTopicEntity {
  StoryTopicModel(
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

  factory StoryTopicModel.fromMap(Map<String, dynamic> map) {
    return StoryTopicModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      status: map['status'] ?? true,
    );
  }
}
