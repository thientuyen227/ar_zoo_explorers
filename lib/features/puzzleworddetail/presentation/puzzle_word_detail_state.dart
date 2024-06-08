import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';

class PuzzleWordDetailState {
  final PageStatus pageStatus;
  List<QuestionEntity>? questionEntities;
  double height;
  double width;

  PuzzleWordDetailState(
      {this.pageStatus = PageStatus.loading,
      this.questionEntities = const [],
      this.height = 0,
      this.width = 0});

  PuzzleWordDetailState copyWith(
      {PageStatus? pageStatus,
      List<QuestionEntity>? questionEntities,
      double? height,
      double? width}) {
    return PuzzleWordDetailState(
        pageStatus: pageStatus ?? this.pageStatus,
        questionEntities: questionEntities ?? this.questionEntities,
        height: height ?? this.height,
        width: width ?? this.width);
  }
}
