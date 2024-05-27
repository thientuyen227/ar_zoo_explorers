import 'dart:convert';

import 'package:get/get.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuestionEntity {
  String id;
  Map<String, String> question;
  List<Map<String, String>>? options;
  String categoryQuestion;
  String categoryId;
  String? image;
  String answer;
  List<WordFindChar>? puzzles;
  // int? correctAnswerIndex;
  QuestionEntity({
    required this.id,
    required this.question,
    this.options,
    required this.categoryQuestion,
    required this.categoryId,
    required this.image,
    required this.answer,
    this.puzzles,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'options': options,
      'categoryQuestion': categoryQuestion,
      'categoryId': categoryId,
      'image': image,
      'answer': answer,
    };
  }

  factory QuestionEntity.fromMap(Map<String, dynamic> map) {
    return QuestionEntity(
      id: map['id'] as String,
      question: Map<String, String>.from((map['question'])),
      options: map['options'] != null
          ? (map['options'] as List<dynamic>)
              .map((x) => Map<String, String>.from(x as Map))
              .toList()
          : null,
      categoryQuestion: map['categoryQuestion'] as String,
      categoryId: map['categoryId'] as String,
      image: map['image'] as String?,
      answer: map['answer'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionEntity.fromJson(String source) =>
      QuestionEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  QuestionEntity copyWith({
    String? id,
    required Map<String, String> question,
    List<Map<String, String>>? options,
    String? categoryQuestion,
    String? categoryId,
    String? image,
    required String answer,
  }) {
    return QuestionEntity(
      id: id ?? this.id,
      question: question,
      options: options ?? this.options,
      categoryQuestion: categoryQuestion ?? this.categoryQuestion,
      categoryId: categoryId ?? this.categoryId,
      image: image ?? this.image,
      answer: answer,
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

  String get questionLocalize => _getLocalizedValue(question);
}

class WordFindChar {
  String? currentValue;
  int? currentIndex;
  String? correctValue;
  bool hintShow;

  WordFindChar({
    this.hintShow = false,
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
    };
  }
}
