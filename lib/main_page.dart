import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'app/app/app_cubit.dart';
import 'di/injector.dart';

Future<void> runMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  //await Firebase.initializeApp();

  runZonedGuarded(() {
    runApp(const MainPage());
  }, (error, stackTrace) {
    log("runZonedGuarded() $error", error: error, stackTrace: stackTrace);
    //FirebaseCrashlytics.instance.recordError(error, stackTrace);
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
    return MaterialApp.router(
      title: appCubit.appConfig.appName,
      debugShowCheckedModeBanner: false,
      routerDelegate: appCubit.appRouter.delegate(),
      routeInformationParser: appCubit.appRouter.defaultRouteParser(),
    );
  }
}
