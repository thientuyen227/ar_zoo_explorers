import '../../../app/app/app_state.dart';

class WelcomeState {
  final PageStatus pageStatus;
  WelcomeState({
    this.pageStatus = PageStatus.loading,
  });

  WelcomeState copyWith({
    PageStatus? pageStatus,
  }) {
    return WelcomeState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
