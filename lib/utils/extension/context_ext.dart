
import 'package:flutter/material.dart';
import '../../app/app/app_cubit.dart';
import '../../app/theme/themes.dart';

import '../../di/injector.dart';

extension Style on BuildContext {
  AppThemeData get myTheme => getIt<AppCubit>().state.appTheme;
}

extension Navigate on BuildContext {}

extension ScreenSize on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}
