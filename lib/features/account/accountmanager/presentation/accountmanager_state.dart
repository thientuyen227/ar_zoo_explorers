import '../../../../app/app/app_state.dart';

class AccountManagerState {
  final PageStatus pageStatus;
  AccountManagerState({
    this.pageStatus = PageStatus.loading,
  });

  AccountManagerState copyWith({PageStatus? pageStatus}) {
    return AccountManagerState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
