import '../../../app/app/app_state.dart';

class AnimalModelsState {
  final PageStatus pageStatus;
  AnimalModelsState({
    this.pageStatus = PageStatus.loading,
  });

  AnimalModelsState copyWith({PageStatus? pageStatus}) {
    return AnimalModelsState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
