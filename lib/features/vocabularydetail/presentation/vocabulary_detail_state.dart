import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';

class VocabularyDetailState {
  final PageStatus pageStatus;
  final List<VocabularyEntity> vocabularies;
  VocabularyDetailState({
    this.pageStatus = PageStatus.loading,
    this.vocabularies = const [],
  });

  VocabularyDetailState copyWith(
      {PageStatus? pageStatus, List<VocabularyEntity>? vocabularies}) {
    return VocabularyDetailState(
        pageStatus: pageStatus ?? this.pageStatus,
        vocabularies: vocabularies ?? this.vocabularies);
  }
}
