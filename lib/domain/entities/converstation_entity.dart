import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationEntity {
  String id;
  String userId;
  String chatName;
  Timestamp createdAt;
  Timestamp updatedAt;
  bool status;

  ConversationEntity({
    this.id = '',
    this.userId = '',
    this.chatName = '',
    Timestamp? createdAt,
    Timestamp? updatedAt,
    this.status = true,
  })  : createdAt = createdAt ?? Timestamp.now(),
        updatedAt = updatedAt ?? Timestamp.now();
}
