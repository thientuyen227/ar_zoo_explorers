import 'package:cloud_firestore/cloud_firestore.dart';

class MessageEntity {
  String id;
  String userId;
  String content;
  String contentType;
  Timestamp createdAt;
  bool isAI;
  bool status;

  MessageEntity({
    this.id = '',
    this.userId = '',
    this.content = '',
    this.contentType = '',
    Timestamp? createdAt,
    this.isAI = false,
    this.status = true,
  }) : createdAt = createdAt ?? Timestamp.now();
}
