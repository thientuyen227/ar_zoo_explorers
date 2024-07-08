// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserQuestionEntity {
  final String id;
  final String userId;
  final String learningId;
  final Map<String, int?> indexQuestion;

  UserQuestionEntity(
      {required this.id,
      required this.userId,
      required this.learningId,
      required this.indexQuestion});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'learningId': learningId,
      'indexQuestion': indexQuestion,
    };
  }

  factory UserQuestionEntity.fromMap(Map<String, dynamic> map) {
    return UserQuestionEntity(
      id: map['id'] as String,
      userId: map['userId'] as String,
      learningId: map['learningId'] as String,
      indexQuestion: Map<String, int>.from((map['indexQuestion'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserQuestionEntity.fromJson(String source) =>
      UserQuestionEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  UserQuestionEntity copyWith({
    String? id,
    String? userId,
    String? learningId,
    Map<String, int?>? indexQuestion,
  }) {
    return UserQuestionEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      learningId: learningId ?? this.learningId,
      indexQuestion: indexQuestion ?? this.indexQuestion,
    );
  }
}
