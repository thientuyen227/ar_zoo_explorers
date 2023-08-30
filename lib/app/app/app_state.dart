import 'package:ar_zoo_explorers/app/theme/themes.dart';

enum PageStatus { loading, idle, error }

class AppState {
  final AppThemeData appTheme;
  final PageStatus status;
  AppState({
    required this.appTheme,
    required this.status,
  });

  AppState copyWith({
    AppThemeData? appTheme,
    PageStatus? status,
  }) {
    return AppState(
      appTheme: appTheme ?? this.appTheme,
      status: status ?? this.status,
    );
  }

  @override
  String toString() => 'AppState(appTheme: $appTheme, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState && other.appTheme == appTheme && other.status == status;
  }

  @override
  int get hashCode => appTheme.hashCode ^ status.hashCode;
}
