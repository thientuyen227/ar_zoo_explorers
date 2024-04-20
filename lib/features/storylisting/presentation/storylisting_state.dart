import 'package:ar_zoo_explorers/app/app/app_state.dart';

class StoryListingState {
  final PageStatus pageStatus;
  StoryListingState({
    this.pageStatus = PageStatus.loading,
  });

  StoryListingState copyWith({PageStatus? pageStatus}) {
    return StoryListingState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
