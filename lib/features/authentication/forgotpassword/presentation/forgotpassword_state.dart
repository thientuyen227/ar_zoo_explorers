import '../../../../app/app/app_state.dart';

class ForgotPasswordState {
  final PageStatus pageStatus;
  ForgotPasswordState({
    this.pageStatus = PageStatus.loading,
  });

  // ForgotPasswordState copyWith({PageStatus? pageStatus}) {
  //   return ForgotPasswordState(
  //     pageStatus: pageStatus ?? this.pageStatus,
  //   );
  // }
}
