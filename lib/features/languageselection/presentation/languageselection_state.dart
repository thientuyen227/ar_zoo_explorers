import '../../../app/app/app_state.dart';

class LanguageSelectionState {
  final PageStatus pageStatus;
  LanguageSelectionState({
    this.pageStatus = PageStatus.loading,
  });

  LanguageSelectionState copyWith({
    PageStatus? pageStatus,
  }) {
    return LanguageSelectionState(
      pageStatus: pageStatus ?? this.pageStatus,
    );
  }
}
