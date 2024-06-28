import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WritingPracticeUserEntity {
  String id;
  String userId;
  String writingPracticeId;
  Map<String?, String?> practicedImagePaths;
  WritingPracticeUserEntity({
    required this.id,
    required this.userId,
    required this.writingPracticeId,
    required this.practicedImagePaths,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'writingPracticeId': writingPracticeId,
      'practicedImagePaths': practicedImagePaths,
    };
  }

  factory WritingPracticeUserEntity.fromMap(Map<String, dynamic> map) {
    return WritingPracticeUserEntity(
      id: map['id'] as String,
      userId: map['userId'] as String,
      writingPracticeId: map['writingPracticeId'] as String,
      practicedImagePaths: map['practicedImagePaths'] != null
          ? Map<String?, String?>.from(map['practicedImagePaths'] as Map)
          : <String?, String?>{},
    );
  }

  String toJson() => json.encode(toMap());

  factory WritingPracticeUserEntity.fromJson(String source) =>
      WritingPracticeUserEntity.fromMap(
          json.decode(source) as Map<String, dynamic>);

  WritingPracticeUserEntity copyWith({
    String? id,
    String? userId,
    String? writingPracticeId,
    Map<String?, String?>? practicedImagePaths,
  }) {
    return WritingPracticeUserEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      writingPracticeId: writingPracticeId ?? this.writingPracticeId,
      practicedImagePaths: practicedImagePaths ?? this.practicedImagePaths,
    );
  }
}
