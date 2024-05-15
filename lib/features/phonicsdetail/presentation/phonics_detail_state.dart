import 'package:ar_zoo_explorers/app/app/app_state.dart';

class PhonicsDetailState {
  final PageStatus pageStatus;
  PhonicsDetailState({
    this.pageStatus = PageStatus.loading,
  });

  PhonicsDetailState copyWith({PageStatus? pageStatus}) {
    return PhonicsDetailState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
