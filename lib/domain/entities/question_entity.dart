import 'dart:convert';

import 'package:get/get.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuestionEntity {
  String id;
  Map<String, String> questions;
  List<Map<String, String>>? options;
  Map<String, String> answers;
  String categoryId;
  final String vocabularyId;
  String? image;
  String? answer;
  List<WordFindChar>? puzzles;
  // int? correctAnswerIndex;
  QuestionEntity({
    required this.id,
    required this.questions,
    this.options,
    required this.answers,
    required this.categoryId,
    required this.vocabularyId,
    required this.image,
    this.answer,
    this.puzzles,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': questions,
      'answers': answers,
      'options': options,
      'categoryId': categoryId,
      'vocabularyId': vocabularyId,
      'image': image,
      'answer': answer,
    };
  }

  factory QuestionEntity.fromMap(Map<String, dynamic> map) {
    return QuestionEntity(
      id: map['id'] as String,
      questions: Map<String, String>.from((map['questions'])),
      answers: map['answers'] is Map<String, dynamic>
          ? Map<String, String>.from(map['answers'])
          : <String, String>{},
      options: map['options'] != null
          ? (map['options'] as List<dynamic>)
              .map((x) => Map<String, String>.from(x as Map))
              .toList()
          : null,
      categoryId: map['categoryId'] as String,
      vocabularyId: map['vocabularyId'] as String,
      image: map['image'] as String?,
      answer: map['answer'] != null ? map['answer'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionEntity.fromJson(String source) =>
      QuestionEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  QuestionEntity copyWith({
    String? id,
    required Map<String, String> questions,
    List<Map<String, String>>? options,
    Map<String, String>? answers,
    String? categoryId,
    String? vocabularyId,
    String? image,
    String? answer,
  }) {
    return QuestionEntity(
      id: id ?? this.id,
      questions: questions,
      answers: answers ?? this.answers,
      options: options ?? this.options,
      categoryId: categoryId ?? this.categoryId,
      vocabularyId: vocabularyId ?? this.vocabularyId,
      image: image ?? this.image,
      answer: answer ?? this.answer,
    );
  }
}

extension QuestionEntityExt on QuestionEntity {
  String _getLocalizedValue(Map<String, String> data) {
    final languageCode = Get.locale?.languageCode;
    return data.containsKey(languageCode)
        ? data[languageCode]!
        : data.values.firstOrNull ?? "";
  }

  String get questionLocalize => _getLocalizedValue(questions);
  String get answerLocalize => _getLocalizedValue(answers);
}

class WordFindChar {
  String? currentValue;
  int? currentIndex;
  String? correctValue;
  bool? isChose;
  bool hintShow;

  WordFindChar({
    this.hintShow = false,
    this.isChose = false,
    this.correctValue,
    this.currentIndex,
    this.currentValue,
  });

  getCurrentValue() {
    if (correctValue != null) {
      return currentValue?.toUpperCase();
    } else if (hintShow) {
      return correctValue?.toUpperCase();
    }
  }

  void clearValue() {
    currentIndex = null;
    currentValue = null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentValue': currentValue,
      'currentIndex': currentIndex,
      'correctValue': correctValue,
      'hintShow': hintShow,
      'isChose': isChose
    };
  }
}
