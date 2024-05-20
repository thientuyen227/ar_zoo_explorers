import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';

class VocabularyState {
  final PageStatus pageStatus;
  final List<VocabularyEntity> vocabularies;
  VocabularyState({
    this.pageStatus = PageStatus.loading,
    this.vocabularies = const [],
  });

  VocabularyState copyWith(
      {PageStatus? pageStatus, List<VocabularyEntity>? vocabularies}) {
    return VocabularyState(
        pageStatus: pageStatus ?? this.pageStatus,
        vocabularies: vocabularies ?? this.vocabularies);
  }
}
