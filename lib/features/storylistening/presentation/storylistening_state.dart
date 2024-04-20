import 'package:ar_zoo_explorers/app/app/app_state.dart';

class StoryListeningState {
  final PageStatus pageStatus;
  StoryListeningState({
    this.pageStatus = PageStatus.loading,
  });

  StoryListeningState copyWith({PageStatus? pageStatus}) {
    return StoryListeningState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
