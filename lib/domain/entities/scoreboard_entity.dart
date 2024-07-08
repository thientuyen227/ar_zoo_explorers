// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ScoreboardEntity {
  final String id;
  final String userId;
  final String learningId;
  final String vocabularyId;
  final bool isAudio;
  final bool isQuestion;

  ScoreboardEntity({
    required this.id,
    required this.userId,
    required this.learningId,
    required this.vocabularyId,
    required this.isAudio,
    required this.isQuestion,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'learningId': learningId,
      'vocabularyId': vocabularyId,
      'isAudio': isAudio,
      'isQuestion': isQuestion,
    };
  }

  factory ScoreboardEntity.fromMap(Map<String, dynamic> map) {
    return ScoreboardEntity(
      id: map['id'] as String,
      userId: map['userId'] as String,
      learningId: map['learningId'] as String,
      vocabularyId: map['vocabularyId'] as String,
      isAudio: map['isAudio'] as bool,
      isQuestion: map['isQuestion'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScoreboardEntity.fromJson(String source) =>
      ScoreboardEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  ScoreboardEntity copyWith({
    String? id,
    String? userId,
    String? learningId,
    String? vocabularyId,
    bool? isAudio,
    bool? isQuestion,
  }) {
    return ScoreboardEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      learningId: learningId ?? this.learningId,
      vocabularyId: vocabularyId ?? this.vocabularyId,
      isAudio: isAudio ?? this.isAudio,
      isQuestion: isQuestion ?? this.isQuestion,
    );
  }
}
