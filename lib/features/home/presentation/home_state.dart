import '../../../app/app/app_state.dart';

class HomeState {
  final PageStatus pageStatus;
  HomeState({
    this.pageStatus = PageStatus.loading,
  });

  HomeState copyWith({
    PageStatus? pageStatus,
  }) {
    return HomeState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
