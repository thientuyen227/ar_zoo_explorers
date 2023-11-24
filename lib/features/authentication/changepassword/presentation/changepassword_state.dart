import '../../../../app/app/app_state.dart';

class ChangePasswordState {
  final PageStatus pageStatus;
  ChangePasswordState({
    this.pageStatus = PageStatus.loading,
  });

  ChangePasswordState copyWith({PageStatus? pageStatus}) {
    return ChangePasswordState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
