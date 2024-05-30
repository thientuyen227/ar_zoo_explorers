import 'package:ar_zoo_explorers/domain/entities/converstation_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({
    required super.id,
    required super.userId,
    required super.chatName,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'chatName': chatName,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'status': status,
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      chatName: map['chatName'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
      status: map['status'],
    );
  }
}
