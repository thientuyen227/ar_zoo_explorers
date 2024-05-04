import 'package:cloud_firestore/cloud_firestore.dart';

class StoryEntity {
  String id;
  String author;
  String avatar;
  String content;
  int duration;
  int listenCount;
  List<String> modelId;
  String name;
  String overView;
  String reader;
  Timestamp releaseDate;
  String sourceUrl;
  bool status;
  String title;
  List<String> topicId;
  StoryEntity(
      {this.id = "",
      this.author = "",
      this.avatar = "",
      this.content = "",
      this.duration = 0,
      this.listenCount = 0,
      required List<dynamic>? modelId,
      this.overView = "",
      this.reader = "",
      Timestamp? releaseDate,
      this.sourceUrl = "",
      this.status = true,
      this.name = "",
      this.title = "",
      List<dynamic>? topicId})
      : modelId = List<String>.from(modelId ?? []),
        releaseDate = releaseDate ?? Timestamp.now(),
        topicId = List<String>.from(topicId ?? []);
}
