import 'package:ar_zoo_explorers/app/app/app_state.dart';

class VocabularyDetailState {
  final PageStatus pageStatus;
  VocabularyDetailState({
    this.pageStatus = PageStatus.loading,
  });

  VocabularyDetailState copyWith({PageStatus? pageStatus}) {
    return VocabularyDetailState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
