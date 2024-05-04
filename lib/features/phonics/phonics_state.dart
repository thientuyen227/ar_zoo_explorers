import 'package:ar_zoo_explorers/app/app/app_state.dart';

class PhonicsState {
  final PageStatus pageStatus;
  PhonicsState({
    this.pageStatus = PageStatus.loading,
  });

  PhonicsState copyWith({PageStatus? pageStatus}) {
    return PhonicsState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
