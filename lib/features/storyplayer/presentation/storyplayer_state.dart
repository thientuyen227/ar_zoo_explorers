import '../../../app/app/app_state.dart';

class StoryPlayerState {
  final PageStatus pageStatus;
  StoryPlayerState({
    this.pageStatus = PageStatus.loading,
  });

  StoryPlayerState copyWith({PageStatus? pageStatus}) {
    return StoryPlayerState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
