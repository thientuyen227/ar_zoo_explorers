import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/learning_category_entity.dart';

class VocabularyState {
  final PageStatus pageStatus;
  final List<LearningCategoryEntity> learningcategories;
  VocabularyState({
    this.pageStatus = PageStatus.loading,
    this.learningcategories = const [],
  });

  VocabularyState copyWith(
      {PageStatus? pageStatus,
      List<LearningCategoryEntity>? learningcategories}) {
    return VocabularyState(
        pageStatus: pageStatus ?? this.pageStatus,
        learningcategories: learningcategories ?? this.learningcategories);
  }
}
