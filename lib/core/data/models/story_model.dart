import 'package:ar_zoo_explorers/domain/entities/story_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModel extends StoryEntity {
  StoryModel(
      {required super.id,
      required super.author,
      required super.avatar,
      required super.content,
      required super.duration,
      required super.listenCount,
      required super.modelId,
      required super.name,
      required super.overView,
      required super.reader,
      required super.releaseDate,
      required super.sourceUrl,
      required super.status,
      required super.title,
      required super.topicId});
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'author': author,
      'avatar': avatar,
      'content': content,
      'duration': duration,
      'listenCount': listenCount,
      'modelId': modelId,
      'name': name,
      'overView': overView,
      'reader': reader,
      'releaseDate': releaseDate,
      'sourceUrl': sourceUrl,
      'status': status,
      'title': title,
      'topicId': topicId
    };
  }

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      id: map['id'] ?? '',
      author: map['author'] ?? '',
      avatar: map['avatar'] ?? '',
      content: map['content'] ?? '',
      duration: map['duration'] ?? 0,
      listenCount: map['listenCount'] ?? 0,
      modelId: map['modelId'] ?? [],
      name: map['name'] ?? '',
      overView: map['overView'] ?? '',
      reader: map['reader'] ?? '',
      releaseDate: map['releaseDate'] ?? Timestamp.now(),
      sourceUrl: map['sourceUrl'] ?? '',
      status: map['status'] ?? true,
      title: map['title'] ?? '',
      topicId: map['topicId'] ?? [],
    );
  }
}
