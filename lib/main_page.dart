import 'dart:async';
import 'dart:developer';

import 'package:ar_zoo_explorers/app/languages/localization_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_it/get_it.dart';

import 'app/app/app_cubit.dart';
import 'di/injector.dart';

Future<void> runMain() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    configureDependencies();

    await Firebase.initializeApp();

    runApp(const MainPage());
  }, (error, stackTrace) {
    log("runZonedGuarded() $error", error: error, stackTrace: stackTrace);
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final appCubit = GetIt.instance<AppCubit>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: appCubit.appConfig.appName,
      debugShowCheckedModeBanner: false,
      routerDelegate: appCubit.appRouter.delegate(),
      routeInformationParser: appCubit.appRouter.defaultRouteParser(),
      // Localization
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      //theme: appCubit.state.appTheme.themeData,
    );
  }
}
