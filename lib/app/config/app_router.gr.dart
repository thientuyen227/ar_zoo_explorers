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
    as _i21;
import 'package:ar_zoo_explorers/features/account/userprofile/presentation/userprofile_page.dart'
    as _i22;
import 'package:ar_zoo_explorers/features/animalmodels/presentation/animalmodels_page.dart'
    as _i3;
import 'package:ar_zoo_explorers/features/ar/presentation/ar_page.dart' as _i1;
import 'package:ar_zoo_explorers/features/authentication/changepassword/presentation/changepassword_page.dart'
    as _i5;
import 'package:ar_zoo_explorers/features/authentication/forgotpassword/presentation/forgotpassword_page.dart'
    as _i6;
import 'package:ar_zoo_explorers/features/authentication/login/presentation/login_page.dart'
    as _i10;
import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_page.dart'
    as _i13;
import 'package:ar_zoo_explorers/features/authentication/resetpassword/presentation/resetpassword_page.dart'
    as _i14;
import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_page.dart'
    as _i19;
import 'package:ar_zoo_explorers/features/home/presentation/home_page.dart'
    as _i7;
import 'package:ar_zoo_explorers/features/languageselection/presentation/languageselection_page.dart'
    as _i8;
import 'package:ar_zoo_explorers/features/learning/presentation/learning_page.dart'
    as _i9;
import 'package:ar_zoo_explorers/features/modeldetail/presentation/modeldetail_page.dart'
    as _i12;
import 'package:ar_zoo_explorers/features/searchmodel/presentation/searchmodel_page.dart'
    as _i15;
import 'package:ar_zoo_explorers/features/setting/presentation/setting_page.dart'
    as _i16;
import 'package:ar_zoo_explorers/features/splash/splash_page.dart' as _i17;
import 'package:ar_zoo_explorers/features/story/presentation/story_page.dart'
    as _i18;
import 'package:ar_zoo_explorers/features/testunity/presentation/test_unity.dart'
    as _i20;
import 'package:ar_zoo_explorers/features/welcome/presentation/welcome_page.dart'
    as _i23;
import 'package:ar_zoo_explorers/main_page.dart' as _i11;
import 'package:auto_route/auto_route.dart' as _i24;

abstract class $AppRouter extends _i24.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i24.PageFactory> pagesMap = {
    ARRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ARPage(),
      );
    },
    AccountManagerRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AccountManagerPage(),
      );
    },
    AnimalModelsRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AnimalModelsPage(),
      );
    },
    AppRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AppPage(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ChangePasswordPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ForgotPasswordPage(),
      );
    },
    HelpRoute.name: (routeData) {
      return _i23.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.HelpPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.HomePage(),
      );
    },
    LanguageSelectionRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.LanguageSelectionPage(),
      );
    },
    LearningRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.LearningPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.MainPage(),
      );
    },
    ModelDetailRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.ModelDetailPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.RegisterPage(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.ResetPasswordPage(),
      );
    },
    SearchModelRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.SearchModelPage(),
      );
    },
    SettingRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.SettingPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.SplashPage(),
      );
    },
    StoryRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.StoryPage(),
      );
    },
    TermOfServiceRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.TermOfServicePage(),
      );
    },
    TestUnity.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.TestUnity(),
      );
    },
    UserInformationRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.UserInformationPage(),
      );
    },
    UserProfileRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.UserProfilePage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i24.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ARPage]
class ARRoute extends _i24.PageRouteInfo<void> {
  const ARRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ARRoute.name,
          initialChildren: children,
        );

  static const String name = 'ARRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AccountManagerPage]
class AccountManagerRoute extends _i24.PageRouteInfo<void> {
  const AccountManagerRoute({List<_i24.PageRouteInfo>? children})
      : super(
          AccountManagerRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountManagerRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AnimalModelsPage]
class AnimalModelsRoute extends _i24.PageRouteInfo<void> {
  const AnimalModelsRoute({List<_i24.PageRouteInfo>? children})
      : super(
          AnimalModelsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnimalModelsRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AppPage]
class AppRoute extends _i24.PageRouteInfo<void> {
  const AppRoute({List<_i24.PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ChangePasswordPage]
class ChangePasswordRoute extends _i24.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ForgotPasswordPage]
class ForgotPasswordRoute extends _i24.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i24.PageRouteInfo<void> {
  const HomeRoute({List<_i24.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i8.LanguageSelectionPage]
class LanguageSelectionRoute extends _i24.PageRouteInfo<void> {
  const LanguageSelectionRoute({List<_i24.PageRouteInfo>? children})
      : super(
          LanguageSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageSelectionRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i9.LearningPage]
class LearningRoute extends _i24.PageRouteInfo<void> {
  const LearningRoute({List<_i24.PageRouteInfo>? children})
      : super(
          LearningRoute.name,
          initialChildren: children,
        );

  static const String name = 'LearningRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i10.LoginPage]
class LoginRoute extends _i24.PageRouteInfo<void> {
  const LoginRoute({List<_i24.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i11.MainPage]
class MainRoute extends _i24.PageRouteInfo<void> {
  const MainRoute({List<_i24.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i12.ModelDetailPage]
class ModelDetailRoute extends _i24.PageRouteInfo<void> {
  const ModelDetailRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ModelDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'ModelDetailRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i13.RegisterPage]
class RegisterRoute extends _i24.PageRouteInfo<void> {
  const RegisterRoute({List<_i24.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i14.ResetPasswordPage]
class ResetPasswordRoute extends _i24.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i15.SearchModelPage]
class SearchModelRoute extends _i24.PageRouteInfo<void> {
  const SearchModelRoute({List<_i24.PageRouteInfo>? children})
      : super(
          SearchModelRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchModelRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i16.SettingPage]
class SettingRoute extends _i24.PageRouteInfo<void> {
  const SettingRoute({List<_i24.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i17.SplashPage]
class SplashRoute extends _i24.PageRouteInfo<void> {
  const SplashRoute({List<_i24.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i18.StoryPage]
class StoryRoute extends _i24.PageRouteInfo<void> {
  const StoryRoute({List<_i24.PageRouteInfo>? children})
      : super(
          StoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoryRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i19.TermOfServicePage]
class TermOfServiceRoute extends _i24.PageRouteInfo<void> {
  const TermOfServiceRoute({List<_i24.PageRouteInfo>? children})
      : super(
          TermOfServiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermOfServiceRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i20.TestUnity]
class TestUnity extends _i24.PageRouteInfo<void> {
  const TestUnity({List<_i24.PageRouteInfo>? children})
      : super(
          TestUnity.name,
          initialChildren: children,
        );

  static const String name = 'TestUnity';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i21.UserInformationPage]
class UserInformationRoute extends _i24.PageRouteInfo<void> {
  const UserInformationRoute({List<_i24.PageRouteInfo>? children})
      : super(
          UserInformationRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserInformationRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i22.UserProfilePage]
class UserProfileRoute extends _i24.PageRouteInfo<void> {
  const UserProfileRoute({List<_i24.PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}

/// generated route for
/// [_i23.WelcomePage]
class WelcomeRoute extends _i24.PageRouteInfo<void> {
  const WelcomeRoute({List<_i24.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i24.PageInfo<void> page = _i24.PageInfo<void>(name);
}
