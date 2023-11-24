import '../../../../app/app/app_state.dart';

class ResetPasswordState {
  final PageStatus pageStatus;
  ResetPasswordState({
    this.pageStatus = PageStatus.loading,
  });

  ResetPasswordState copyWith({PageStatus? pageStatus}) {
    return ResetPasswordState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
