import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';

class PuzzleWordDetailState {
  final PageStatus pageStatus;
  List<QuestionEntity>? questionEntities;

  PuzzleWordDetailState({
    this.pageStatus = PageStatus.loading,
    this.questionEntities = const [],
  });

  PuzzleWordDetailState copyWith(
      {PageStatus? pageStatus, List<QuestionEntity>? questionEntities}) {
    return PuzzleWordDetailState(
        pageStatus: pageStatus ?? this.pageStatus,
        questionEntities: questionEntities ?? this.questionEntities);
  }
}
