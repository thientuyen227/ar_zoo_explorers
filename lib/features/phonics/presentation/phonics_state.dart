import 'package:ar_zoo_explorers/app/app/app_state.dart';

class PhonicsState {
  final PageStatus pageStatus;
  double width;
  double height;
  PhonicsState({
    this.pageStatus = PageStatus.loading,
    this.height = 0,
    this.width = 0,
  });

  PhonicsState copyWith({
    PageStatus? pageStatus,
    double? height,
    double? width,
  }) {
    return PhonicsState(
      height: height ?? this.height,
      width: width ?? this.width,
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
