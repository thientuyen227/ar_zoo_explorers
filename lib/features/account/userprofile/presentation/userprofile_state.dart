import '../../../../app/app/app_state.dart';

class UserProfileState {
  final PageStatus pageStatus;
  UserProfileState({
    this.pageStatus = PageStatus.loading,
  });

  UserProfileState copyWith({PageStatus? pageStatus}) {
    return UserProfileState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
