import 'package:ar_zoo_explorers/app/app/app_state.dart';

class StorySearchingState {
  final PageStatus pageStatus;
  StorySearchingState({
    this.pageStatus = PageStatus.loading,
  });

  StorySearchingState copyWith({PageStatus? pageStatus}) {
    return StorySearchingState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
