import 'package:ar_zoo_explorers/app/app/app_state.dart';

class StoryOverviewState {
  final PageStatus pageStatus;
  StoryOverviewState({
    this.pageStatus = PageStatus.loading,
  });

  StoryOverviewState copyWith({PageStatus? pageStatus}) {
    return StoryOverviewState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
