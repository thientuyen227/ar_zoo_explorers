import 'package:ar_zoo_explorers/app/app/app_state.dart';

class StoryHomeState {
  final PageStatus pageStatus;
  StoryHomeState({
    this.pageStatus = PageStatus.loading,
  });

  StoryHomeState copyWith({PageStatus? pageStatus}) {
    return StoryHomeState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
