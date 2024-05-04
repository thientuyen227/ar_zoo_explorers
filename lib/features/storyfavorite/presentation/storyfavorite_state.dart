import 'package:ar_zoo_explorers/app/app/app_state.dart';

class StoryFavoriteState {
  final PageStatus pageStatus;
  StoryFavoriteState({
    this.pageStatus = PageStatus.loading,
  });

  StoryFavoriteState copyWith({PageStatus? pageStatus}) {
    return StoryFavoriteState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
