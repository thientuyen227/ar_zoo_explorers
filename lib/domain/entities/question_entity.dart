// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuestionEntity {
  String question;
  List<String> options;
  String categoryQuestion;
  String? image;
  String? answer;

  int correctAnswerIndex;
  QuestionEntity({
    required this.question,
    required this.options,
    required this.categoryQuestion,
    required this.image,
    required this.correctAnswerIndex,
    required this.answer,
    required String questionEntity,
  });
}
