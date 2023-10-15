import '../../../../app/app/app_state.dart';

class InformationState {
  final PageStatus pageStatus;
  InformationState({
    this.pageStatus = PageStatus.loading,
  });

  InformationState copyWith({PageStatus? pageStatus}) {
    return InformationState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
