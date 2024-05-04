import 'package:ar_zoo_explorers/app/app/app_state.dart';

class StoryTopicState {
  final PageStatus pageStatus;
  StoryTopicState({
    this.pageStatus = PageStatus.loading,
  });

  StoryTopicState copyWith({PageStatus? pageStatus}) {
    return StoryTopicState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
