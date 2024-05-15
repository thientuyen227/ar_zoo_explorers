import 'package:ar_zoo_explorers/app/app/app_state.dart';

class PuzzleWordState {
  final PageStatus pageStatus;
  PuzzleWordState({
    this.pageStatus = PageStatus.loading,
  });

  PuzzleWordState copyWith({PageStatus? pageStatus}) {
    return PuzzleWordState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
