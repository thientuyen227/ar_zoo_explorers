import 'package:ar_zoo_explorers/app/app/app_state.dart';

class VocabularyState {
  final PageStatus pageStatus;
  VocabularyState({
    this.pageStatus = PageStatus.loading,
  });

  VocabularyState copyWith({PageStatus? pageStatus}) {
    return VocabularyState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
