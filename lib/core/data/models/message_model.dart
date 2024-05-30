import 'package:ar_zoo_explorers/domain/entities/message_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.userId,
    required super.content,
    required super.contentType,
    required super.createdAt,
    required super.isAI,
    required super.status,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
      'contentType': contentType,
      'createdAt': createdAt,
      'isAI': isAI,
      'status': status,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      content: map['content'] ?? '',
      contentType: map['contentType'] ?? '',
      isAI: map['isAI'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
      status: map['status'],
    );
  }
}
