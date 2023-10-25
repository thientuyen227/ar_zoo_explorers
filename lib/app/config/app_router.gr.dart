// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ar_zoo_explorers/app/app/app_page.dart' as _i3;
import 'package:ar_zoo_explorers/features/account/accountmanager/presentation/accountmanager_page.dart'
    as _i2;
import 'package:ar_zoo_explorers/features/account/userprofile/presentation/userprofile_page.dart'
    as _i12;
import 'package:ar_zoo_explorers/features/ar/presentation/ar_page.dart' as _i1;
import 'package:ar_zoo_explorers/features/authentication/login/presentation/login_page.dart'
    as _i5;
import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_page.dart'
    as _i7;
import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_page.dart'
    as _i10;
import 'package:ar_zoo_explorers/features/home/presentation/home_page.dart'
    as _i4;
import 'package:ar_zoo_explorers/features/setting/presentation/setting_page.dart'
    as _i8;
import 'package:ar_zoo_explorers/features/splash/splash_page.dart' as _i9;
import 'package:ar_zoo_explorers/features/testunity/presentation/test_unity.dart'
    as _i11;
import 'package:ar_zoo_explorers/features/welcome/presentation/welcome_page.dart'
    as _i13;
import 'package:ar_zoo_explorers/main_page.dart' as _i6;
import 'package:auto_route/auto_route.dart' as _i14;

abstract class $AppRouter extends _i14.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    ARRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ARPage(),
      );
    },
    AccountManagerRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AccountManagerPage(),
      );
    },
    AppRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AppPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.MainPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.RegisterPage(),
      );
    },
    SettingRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SettingPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SplashPage(),
      );
    },
    TermOfServiceRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.TermOfServicePage(),
      );
    },
    TestUnity.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.TestUnity(),
      );
    },
    UserProfileRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.UserProfilePage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ARPage]
class ARRoute extends _i14.PageRouteInfo<void> {
  const ARRoute({List<_i14.PageRouteInfo>? children})
      : super(
          ARRoute.name,
          initialChildren: children,
        );

  static const String name = 'ARRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AccountManagerPage]
class AccountManagerRoute extends _i14.PageRouteInfo<void> {
  const AccountManagerRoute({List<_i14.PageRouteInfo>? children})
      : super(
          AccountManagerRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountManagerRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AppPage]
class AppRoute extends _i14.PageRouteInfo<void> {
  const AppRoute({List<_i14.PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i14.PageRouteInfo<void> {
  const HomeRoute({List<_i14.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginPage]
class LoginRoute extends _i14.PageRouteInfo<void> {
  const LoginRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i6.MainPage]
class MainRoute extends _i14.PageRouteInfo<void> {
  const MainRoute({List<_i14.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i7.RegisterPage]
class RegisterRoute extends _i14.PageRouteInfo<void> {
  const RegisterRoute({List<_i14.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SettingPage]
class SettingRoute extends _i14.PageRouteInfo<void> {
  const SettingRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SplashPage]
class SplashRoute extends _i14.PageRouteInfo<void> {
  const SplashRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i10.TermOfServicePage]
class TermOfServiceRoute extends _i14.PageRouteInfo<void> {
  const TermOfServiceRoute({List<_i14.PageRouteInfo>? children})
      : super(
          TermOfServiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermOfServiceRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i11.TestUnity]
class TestUnity extends _i14.PageRouteInfo<void> {
  const TestUnity({List<_i14.PageRouteInfo>? children})
      : super(
          TestUnity.name,
          initialChildren: children,
        );

  static const String name = 'TestUnity';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i12.UserProfilePage]
class UserProfileRoute extends _i14.PageRouteInfo<void> {
  const UserProfileRoute({List<_i14.PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i13.WelcomePage]
class WelcomeRoute extends _i14.PageRouteInfo<void> {
  const WelcomeRoute({List<_i14.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}
