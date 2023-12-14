import '../../../app/app/app_state.dart';

class SearchModelState {
  final PageStatus pageStatus;
  SearchModelState({
    this.pageStatus = PageStatus.loading,
  });

  SearchModelState copyWith({PageStatus? pageStatus}) {
    return SearchModelState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
