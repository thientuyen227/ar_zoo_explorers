import '../../../../app/app/app_state.dart';

class UserProfileState {
  final PageStatus pageStatus;

  double height;
  double width;

  UserProfileState({
    this.pageStatus = PageStatus.loading,
    this.height = 0,
    this.width = 0,
  });

  UserProfileState copyWith({
    PageStatus? pageStatus,
    double? height,
    double? width,
  }) {
    return UserProfileState(
      pageStatus: pageStatus ?? this.pageStatus,
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }

  setAttributes({
    double? height,
    double? width,
  }) async {
    this.height = height ?? this.height;
    this.width = width ?? this.width;
  }
}
