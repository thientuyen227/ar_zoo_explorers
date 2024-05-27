import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';

class PuzzleState {
  final PageStatus pageStatus;
  List<QuestionEntity>? questionEntities;

  PuzzleState({
    this.pageStatus = PageStatus.loading,
    this.questionEntities = const [],
  });

  PuzzleState copyWith(
      {PageStatus? pageStatus, List<QuestionEntity>? questionEntities}) {
    return PuzzleState(
        pageStatus: pageStatus ?? this.pageStatus,
        questionEntities: questionEntities ?? this.questionEntities);
  }
}
