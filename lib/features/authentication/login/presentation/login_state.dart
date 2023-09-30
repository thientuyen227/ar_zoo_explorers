import '../../../../app/app/app_state.dart';

class LoginState {
  final PageStatus pageStatus;
  LoginState({
    this.pageStatus = PageStatus.loading,
  });

  // LoginState copyWith({PageStatus? pageStatus}) {
  //   return LoginState(
  //     pageStatus: pageStatus ?? this.pageStatus,
  //   );
  // }
}
