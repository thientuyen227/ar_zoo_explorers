import '../../../../app/app/app_state.dart';

class UserInformationState {
  final PageStatus pageStatus;
  UserInformationState({
    this.pageStatus = PageStatus.loading,
  });

  UserInformationState copyWith({PageStatus? pageStatus}) {
    return UserInformationState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
