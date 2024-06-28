import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/learning_category_entity.dart';

class VocabularyState {
  final PageStatus pageStatus;
  final List<LearningCategoryEntity> learningcategories;
  double height;
  double width;
  VocabularyState({
    this.height = 0,
    this.width = 0,
    this.pageStatus = PageStatus.loading,
    this.learningcategories = const [],
  });

  VocabularyState copyWith({
    PageStatus? pageStatus,
    double? height,
    double? width,
    List<LearningCategoryEntity>? learningcategories,
  }) {
    return VocabularyState(
      pageStatus: pageStatus ?? this.pageStatus,
      height: height ?? this.height,
      width: width ?? this.width,
      learningcategories: learningcategories ?? this.learningcategories,
    );
  }
}
