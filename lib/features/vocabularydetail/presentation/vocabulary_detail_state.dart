import 'package:ar_zoo_explorers/app/app/app_state.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';

class VocabularyDetailState {
  final PageStatus pageStatus;
  final List<VocabularyEntity> vocabularies;
  double height;
  double width;
  VocabularyDetailState({
    this.pageStatus = PageStatus.loading,
    this.vocabularies = const [],
    this.height = 0,
    this.width = 0,
  });

  VocabularyDetailState copyWith(
      {PageStatus? pageStatus,
      List<VocabularyEntity>? vocabularies,
      double? height,
      double? width}) {
    return VocabularyDetailState(
      pageStatus: pageStatus ?? this.pageStatus,
      height: height ?? this.height,
      width: width ?? this.width,
      vocabularies: vocabularies ?? this.vocabularies,
    );
  }
}
