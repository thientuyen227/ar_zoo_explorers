import '../../../app/app/app_state.dart';

class ModelDetailState {
  final PageStatus pageStatus;
  ModelDetailState({
    this.pageStatus = PageStatus.loading,
  });

  ModelDetailState copyWith({
    PageStatus? pageStatus,
  }) {
    return ModelDetailState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
