import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';

class PuzzleWordState {
  final PageStatus pageStatus;
  List<QuestionEntity>? questionEntities;
  String audio;
  double height;
  double width;

  PuzzleWordState(
      {this.pageStatus = PageStatus.loading,
      this.questionEntities = const [],
      this.audio = '',
      this.height = 0,
      this.width = 0});

  PuzzleWordState copyWith(
      {PageStatus? pageStatus,
      List<QuestionEntity>? questionEntities,
      String? audio,
      double? height,
      double? width}) {
    return PuzzleWordState(
        pageStatus: pageStatus ?? this.pageStatus,
        questionEntities: questionEntities ?? this.questionEntities,
        height: height ?? this.height,
        audio: audio ?? this.audio,
        width: width ?? this.width);
  }
}
