import '../../../app/app/app_state.dart';

class StoryState {
  final PageStatus pageStatus;
  StoryState({
    this.pageStatus = PageStatus.loading,
  });

  StoryState copyWith({PageStatus? pageStatus}) {
    return StoryState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
