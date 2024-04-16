// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuestionEntity {
  String question;
  List<String>? options;
  String categoryQuestion;
  String? image;
  String? answer;
  List<WordFindChar>? puzzles;
  int? correctAnswerIndex;
  QuestionEntity({
    required this.question,
    this.options,
    required this.categoryQuestion,
    this.image,
    required this.answer,
    this.puzzles,
    this.correctAnswerIndex,
  });

  QuestionEntity copyWith({
    String? question,
    List<String>? options,
    String? categoryQuestion,
    String? image,
    String? answer,
    List<WordFindChar>? puzzles,
    int? correctAnswerIndex,
  }) {
    return QuestionEntity(
      question: question ?? this.question,
      options: options ?? this.options,
      categoryQuestion: categoryQuestion ?? this.categoryQuestion,
      image: image ?? this.image,
      answer: answer ?? this.answer,
      puzzles: puzzles ?? this.puzzles,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
    );
  }
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
      return currentValue;
    } else if (hintShow) return correctValue;
  }

  void clearValue() {
    currentIndex = null;
    currentValue = null;
  }
}
