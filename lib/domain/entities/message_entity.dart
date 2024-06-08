// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageEntity {
  String id;
  String userId;
  String content;
  String? imagePath;
  String contentType;
  Timestamp createdAt;
  bool isAI;
  bool status;

  MessageEntity({
    this.id = '',
    this.userId = '',
    this.content = '',
    this.contentType = '',
    this.imagePath = '',
    Timestamp? createdAt,
    this.isAI = false,
    this.status = true,
  }) : createdAt = createdAt ?? Timestamp.now();

  MessageEntity copyWith({
    String? id,
    String? userId,
    String? content,
    String? imagePath,
    String? contentType,
    Timestamp? createdAt,
    bool? isAI,
    bool? status,
  }) {
    return MessageEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      imagePath: imagePath ?? this.imagePath,
      contentType: contentType ?? this.contentType,
      createdAt: createdAt ?? this.createdAt,
      isAI: isAI ?? this.isAI,
      status: status ?? this.status,
    );
  }
}
