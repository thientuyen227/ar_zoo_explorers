import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/learning_category_entity.dart';

class PuzzleWordState {
  final PageStatus pageStatus;
  List<LearningCategoryEntity>? learningcategories;
  PuzzleWordState({
    this.pageStatus = PageStatus.loading,
    this.learningcategories = const [],
  });

  PuzzleWordState copyWith(
      {PageStatus? pageStatus,
      List<LearningCategoryEntity>? learningcategories}) {
    return PuzzleWordState(
      pageStatus: pageStatus ?? this.pageStatus,
      learningcategories: learningcategories ?? this.learningcategories,
    );
  }
}
