import 'package:ar_zoo_explorers/app/app/app_state.dart';

class PuzzleWordDetailState {
  final PageStatus pageStatus;
  PuzzleWordDetailState({
    this.pageStatus = PageStatus.loading,
  });

  PuzzleWordDetailState copyWith({PageStatus? pageStatus}) {
    return PuzzleWordDetailState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
