import '../../../../app/app/app_state.dart';

class TermOfServiceState {
  final PageStatus pageStatus;
  TermOfServiceState({
    this.pageStatus = PageStatus.loading,
  });

  TermOfServiceState copyWith({PageStatus? pageStatus}) {
    return TermOfServiceState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
