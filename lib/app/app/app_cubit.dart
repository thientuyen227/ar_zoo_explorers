import 'dart:async';

import 'package:ar_zoo_explorers/app/config/app_router.dart';
import 'package:ar_zoo_explorers/app/mixin/custom_initialize_mixin.dart';
import 'package:injectable/injectable.dart';

import '../../base/base_cubit.dart';
import '../theme/themes.dart';
import 'app_state.dart';

@singleton
class AppCubit extends BaseCubit<AppState> with CustomInitializeMixin {
  AppCubit() : super(AppState(status: PageStatus.loading, appTheme: AppThemeData.light()));

  final AppRouter appRouter = AppRouter();

  changeTheme(AppThemeData appTheme) {
    emit(state.copyWith(appTheme: appTheme));
  }

  Future<void> init() async {
    // Init App Config
    // Init storekit
    await Future.wait([localStorage.init()]);
    // Init products

    initGPTService();


    emit(state.copyWith(status: PageStatus.idle));
  }

}
