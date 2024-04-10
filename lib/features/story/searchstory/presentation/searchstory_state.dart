import 'package:ar_zoo_explorers/app/app/app_state.dart';

class SearchStoryState {
  final PageStatus pageStatus;
  SearchStoryState({
    this.pageStatus = PageStatus.loading,
  });

  SearchStoryState copyWith({PageStatus? pageStatus}) {
    return SearchStoryState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
