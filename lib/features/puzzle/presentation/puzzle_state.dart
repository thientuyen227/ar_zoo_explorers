import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/learning_category_entity.dart';

class PuzzleState {
  final PageStatus pageStatus;
  List<LearningCategoryEntity>? learningcategories;
  double height;
  double width;
  PuzzleState({
    this.pageStatus = PageStatus.loading,
    this.learningcategories = const [],
    this.height = 0,
    this.width = 0,
  });

  PuzzleState copyWith(
      {PageStatus? pageStatus,
      List<LearningCategoryEntity>? learningcategories,
      double? height,
      double? width}) {
    return PuzzleState(
        pageStatus: pageStatus ?? this.pageStatus,
        learningcategories: learningcategories ?? this.learningcategories,
        height: height ?? this.height,
        width: width ?? this.width);
  }
}
