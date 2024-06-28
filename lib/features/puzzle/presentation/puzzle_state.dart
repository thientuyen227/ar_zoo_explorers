import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';

class PuzzleState {
  final PageStatus pageStatus;
  List<QuestionEntity>? questionEntities;
  List<List<String>?> answersList;
  double height;
  double width;

  PuzzleState({
    this.pageStatus = PageStatus.loading,
    this.questionEntities = const [],
    this.answersList = const [],
    this.height = 0,
    this.width = 0,
  });

  PuzzleState copyWith(
      {PageStatus? pageStatus,
      List<QuestionEntity>? questionEntities,
      List<List<String>?>? answersList,
      double? height,
      double? width}) {
    return PuzzleState(
        pageStatus: pageStatus ?? this.pageStatus,
        questionEntities: questionEntities ?? this.questionEntities,
        answersList: answersList ?? this.answersList,
        height: height ?? this.height,
        width: width ?? this.width);
  }
}
