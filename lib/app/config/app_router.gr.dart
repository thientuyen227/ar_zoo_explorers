// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ar_zoo_explorers/app/app/app_page.dart' as _i4;
import 'package:ar_zoo_explorers/features/account/accountmanager/presentation/accountmanager_page.dart'
    as _i2;
import 'package:ar_zoo_explorers/features/account/userinformation/presentation/userinformation_page.dart'
    as _i17;
import 'package:ar_zoo_explorers/features/account/userprofile/presentation/userprofile_page.dart'
    as _i18;
import 'package:ar_zoo_explorers/features/animalmodels/presentation/animalmodels_page.dart'
    as _i3;
import 'package:ar_zoo_explorers/features/ar/presentation/ar_page.dart' as _i1;
import 'package:ar_zoo_explorers/features/authentication/changepassword/presentation/changepassword_page.dart'
    as _i5;
import 'package:ar_zoo_explorers/features/authentication/forgotpassword/presentation/forgotpassword_page.dart'
    as _i6;
import 'package:ar_zoo_explorers/features/authentication/login/presentation/login_page.dart'
    as _i8;
import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_page.dart'
    as _i11;
import 'package:ar_zoo_explorers/features/authentication/resetpassword/presentation/resetpassword_page.dart'
    as _i12;
import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_page.dart'
    as _i15;
import 'package:ar_zoo_explorers/features/home/presentation/home_page.dart'
    as _i7;
import 'package:ar_zoo_explorers/features/modleldetail/presentation/modeldetail_page.dart'
    as _i10;
import 'package:ar_zoo_explorers/features/setting/presentation/setting_page.dart'
    as _i13;
import 'package:ar_zoo_explorers/features/splash/splash_page.dart' as _i14;
import 'package:ar_zoo_explorers/features/testunity/presentation/test_unity.dart'
    as _i16;
import 'package:ar_zoo_explorers/features/welcome/presentation/welcome_page.dart'
    as _i19;
import 'package:ar_zoo_explorers/main_page.dart' as _i9;
import 'package:auto_route/auto_route.dart' as _i20;

abstract class $AppRouter extends _i20.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i20.PageFactory> pagesMap = {
    ARRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ARPage(),
      );
    },
    AccountManagerRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AccountManagerPage(),
      );
    },
    AnimalModelsRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AnimalModelsPage(),
      );
    },
    AppRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AppPage(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ChangePasswordPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ForgotPasswordPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HomePage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.MainPage(),
      );
    },
    ModelDetailRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ModelDetailPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.RegisterPage(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.ResetPasswordPage(),
      );
    },
    SettingRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.SettingPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.SplashPage(),
      );
    },
    TermOfServiceRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.TermOfServicePage(),
      );
    },
    TestUnity.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.TestUnity(),
      );
    },
    UserInformationRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.UserInformationPage(),
      );
    },
    UserProfileRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.UserProfilePage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i20.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ARPage]
class ARRoute extends _i20.PageRouteInfo<void> {
  const ARRoute({List<_i20.PageRouteInfo>? children})
      : super(
          ARRoute.name,
          initialChildren: children,
        );

  static const String name = 'ARRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AccountManagerPage]
class AccountManagerRoute extends _i20.PageRouteInfo<void> {
  const AccountManagerRoute({List<_i20.PageRouteInfo>? children})
      : super(
          AccountManagerRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountManagerRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AnimalModelsPage]
class AnimalModelsRoute extends _i20.PageRouteInfo<void> {
  const AnimalModelsRoute({List<_i20.PageRouteInfo>? children})
      : super(
          AnimalModelsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnimalModelsRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AppPage]
class AppRoute extends _i20.PageRouteInfo<void> {
  const AppRoute({List<_i20.PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ChangePasswordPage]
class ChangePasswordRoute extends _i20.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i20.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ForgotPasswordPage]
class ForgotPasswordRoute extends _i20.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i20.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i20.PageRouteInfo<void> {
  const HomeRoute({List<_i20.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i8.LoginPage]
class LoginRoute extends _i20.PageRouteInfo<void> {
  const LoginRoute({List<_i20.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i9.MainPage]
class MainRoute extends _i20.PageRouteInfo<void> {
  const MainRoute({List<_i20.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ModelDetailPage]
class ModelDetailRoute extends _i20.PageRouteInfo<void> {
  const ModelDetailRoute({List<_i20.PageRouteInfo>? children})
      : super(
          ModelDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'ModelDetailRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i11.RegisterPage]
class RegisterRoute extends _i20.PageRouteInfo<void> {
  const RegisterRoute({List<_i20.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i12.ResetPasswordPage]
class ResetPasswordRoute extends _i20.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i20.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i13.SettingPage]
class SettingRoute extends _i20.PageRouteInfo<void> {
  const SettingRoute({List<_i20.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i14.SplashPage]
class SplashRoute extends _i20.PageRouteInfo<void> {
  const SplashRoute({List<_i20.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i15.TermOfServicePage]
class TermOfServiceRoute extends _i20.PageRouteInfo<void> {
  const TermOfServiceRoute({List<_i20.PageRouteInfo>? children})
      : super(
          TermOfServiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermOfServiceRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i16.TestUnity]
class TestUnity extends _i20.PageRouteInfo<void> {
  const TestUnity({List<_i20.PageRouteInfo>? children})
      : super(
          TestUnity.name,
          initialChildren: children,
        );

  static const String name = 'TestUnity';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i17.UserInformationPage]
class UserInformationRoute extends _i20.PageRouteInfo<void> {
  const UserInformationRoute({List<_i20.PageRouteInfo>? children})
      : super(
          UserInformationRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserInformationRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i18.UserProfilePage]
class UserProfileRoute extends _i20.PageRouteInfo<void> {
  const UserProfileRoute({List<_i20.PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}

/// generated route for
/// [_i19.WelcomePage]
class WelcomeRoute extends _i20.PageRouteInfo<void> {
  const WelcomeRoute({List<_i20.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i20.PageInfo<void> page = _i20.PageInfo<void>(name);
}
