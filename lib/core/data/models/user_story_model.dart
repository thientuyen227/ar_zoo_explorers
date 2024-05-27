import 'package:ar_zoo_explorers/domain/entities/user_story_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserStoryModel extends UserStoryEntity {
  UserStoryModel({
    required super.id,
    required super.storyId,
    required super.userId,
    required super.pausedTime,
    required super.isCompleted,
    required super.isFavorited,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
  });

  @override
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

  factory UserStoryModel.fromMap(Map<String, dynamic> map) {
    return UserStoryModel(
      id: map['id'] ?? '',
      storyId: map['storyId'] ?? '',
      userId: map['userId'] ?? '',
      pausedTime: map['pausedTime'] ?? 0,
      isCompleted: map['isCompleted'] ?? false,
      isFavorited: map['isFavorited'] ?? false,
      createdAt: map['createdAt'] ?? Timestamp.now(),
      updatedAt: map['updatedAt'] ?? Timestamp.now(),
      status: map['status'],
    );
  }
}
