import 'package:ar_zoo_explorers/app/app/app_state.dart';

class ListStoryState {
  final PageStatus pageStatus;
  ListStoryState({
    this.pageStatus = PageStatus.loading,
  });

  ListStoryState copyWith({PageStatus? pageStatus}) {
    return ListStoryState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
