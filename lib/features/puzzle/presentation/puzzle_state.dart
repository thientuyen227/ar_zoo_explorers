import 'package:ar_zoo_explorers/app/app/app_state.dart';

class PuzzleState {
  final PageStatus pageStatus;
  PuzzleState({
    this.pageStatus = PageStatus.loading,
  });

  PuzzleState copyWith({PageStatus? pageStatus}) {
    return PuzzleState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
