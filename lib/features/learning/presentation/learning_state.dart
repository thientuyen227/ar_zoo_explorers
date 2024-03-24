import '../../../app/app/app_state.dart';

class LearningState {
  final PageStatus pageStatus;
  LearningState({
    this.pageStatus = PageStatus.loading,
  });

  LearningState copyWith({PageStatus? pageStatus}) {
    return LearningState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
