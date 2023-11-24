import '../../../../app/app/app_state.dart';

class ForgotPasswordState {
  final PageStatus pageStatus;
  ForgotPasswordState({
    this.pageStatus = PageStatus.loading,
  });

  // LoginState copyWith({PageStatus? pageStatus}) {
  //   return LoginState(
  //     pageStatus: pageStatus ?? this.pageStatus,
  //   );
  // }
}
