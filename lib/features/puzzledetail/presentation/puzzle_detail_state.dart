import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';

class PuzzleDetailState {
  final PageStatus pageStatus;
  List<QuestionEntity>? questionEntities;
  List<List<String>?> answersList;
  String audio;
  String modelId;
  double height;
  double width;

  PuzzleDetailState({
    this.pageStatus = PageStatus.loading,
    this.questionEntities = const [],
    this.answersList = const [],
    this.audio = '',
    this.modelId = '',
    this.height = 0,
    this.width = 0,
  });

  PuzzleDetailState copyWith(
      {PageStatus? pageStatus,
      List<QuestionEntity>? questionEntities,
      List<List<String>?>? answersList,
      String? audio,
      String? modelId,
      double? height,
      double? width}) {
    return PuzzleDetailState(
        pageStatus: pageStatus ?? this.pageStatus,
        questionEntities: questionEntities ?? this.questionEntities,
        answersList: answersList ?? this.answersList,
        audio: audio ?? this.audio,
        modelId: modelId ?? this.modelId,
        height: height ?? this.height,
        width: width ?? this.width);
  }
}
