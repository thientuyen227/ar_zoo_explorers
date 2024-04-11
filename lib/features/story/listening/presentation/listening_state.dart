import 'package:ar_zoo_explorers/app/app/app_state.dart';

class ListeningState {
  final PageStatus pageStatus;
  ListeningState({
    this.pageStatus = PageStatus.loading,
  });

  ListeningState copyWith({PageStatus? pageStatus}) {
    return ListeningState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
