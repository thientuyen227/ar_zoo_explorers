import 'package:cloud_firestore/cloud_firestore.dart';

class UserStoryEntity {
  String id;
  String storyId;
  String userId;
  int pausedTime;
  bool isCompleted;
  bool isFavorited;
  Timestamp createdAt;
  Timestamp updatedAt;
  bool status;

  UserStoryEntity({
    this.id = '',
    this.storyId = '',
    this.userId = '',
    this.pausedTime = 0,
    this.isCompleted = false,
    this.isFavorited = false,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    this.status = true,
  })  : createdAt = createdAt ?? Timestamp.now(),
        updatedAt = updatedAt ?? Timestamp.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'storyId': storyId,
      'userId': userId,
      'pausedTime': pausedTime,
      'isCompleted': isCompleted,
      'isFavorited': isFavorited,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'status': status,
    };
  }
}
