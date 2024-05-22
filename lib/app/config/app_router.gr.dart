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
    as _i34;
import 'package:ar_zoo_explorers/features/account/userprofile/presentation/userprofile_page.dart'
    as _i35;
import 'package:ar_zoo_explorers/features/animalmodels/presentation/animalmodels_page.dart'
    as _i3;
import 'package:ar_zoo_explorers/features/ar/presentation/ar_page.dart' as _i1;
import 'package:ar_zoo_explorers/features/authentication/changepassword/presentation/changepassword_page.dart'
    as _i6;
import 'package:ar_zoo_explorers/features/authentication/forgotpassword/presentation/forgotpassword_page.dart'
    as _i7;
import 'package:ar_zoo_explorers/features/authentication/login/presentation/login_page.dart'
    as _i12;
import 'package:ar_zoo_explorers/features/authentication/register/presentation/register_page.dart'
    as _i20;
import 'package:ar_zoo_explorers/features/authentication/resetpassword/presentation/resetpassword_page.dart'
    as _i21;
import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_page.dart'
    as _i33;
import 'package:ar_zoo_explorers/features/help/presentation/help_page.dart'
    as _i8;
import 'package:ar_zoo_explorers/features/home/presentation/home_page.dart'
    as _i9;
import 'package:ar_zoo_explorers/features/language/presentation/change_language_page.dart'
    as _i5;
import 'package:ar_zoo_explorers/features/languageselection/presentation/languageselection_page.dart'
    as _i10;
import 'package:ar_zoo_explorers/features/learning/presentation/learning_page.dart'
    as _i11;
import 'package:ar_zoo_explorers/features/modeldetail/presentation/modeldetail_page.dart'
    as _i14;
import 'package:ar_zoo_explorers/features/phonics/presentation/phonics_page.dart'
    as _i16;
import 'package:ar_zoo_explorers/features/phonicsdetail/presentation/phonics_detail_page.dart'
    as _i15;
import 'package:ar_zoo_explorers/features/puzzle/presentation/puzzle_page.dart'
    as _i17;
import 'package:ar_zoo_explorers/features/puzzleword/presentation/puzzle_word_page.dart'
    as _i19;
import 'package:ar_zoo_explorers/features/puzzleworddetail/presentation/puzzle_word_detail_page.dart'
    as _i18;
import 'package:ar_zoo_explorers/features/searchmodel/presentation/searchmodel_page.dart'
    as _i22;
import 'package:ar_zoo_explorers/features/setting/presentation/setting_page.dart'
    as _i23;
import 'package:ar_zoo_explorers/features/splash/splash_page.dart' as _i24;
import 'package:ar_zoo_explorers/features/story/presentation/story_page.dart'
    as _i29;
import 'package:ar_zoo_explorers/features/storyfavorite/presentation/storyfavorite_page.dart'
    as _i25;
import 'package:ar_zoo_explorers/features/storyhome/presentation/storyhome_page.dart'
    as _i26;
import 'package:ar_zoo_explorers/features/storylistening/presentation/storylistening_page.dart'
    as _i27;
import 'package:ar_zoo_explorers/features/storyoverview/presentation/storyoverview_page.dart'
    as _i28;
import 'package:ar_zoo_explorers/features/storyplayer/presentation/storyplayer_page.dart'
    as _i30;
import 'package:ar_zoo_explorers/features/storysearching/presentation/storysearching_page.dart'
    as _i31;
import 'package:ar_zoo_explorers/features/storytopic/presentation/storytopic_page.dart'
    as _i32;
import 'package:ar_zoo_explorers/features/vocabulary/presentation/vocabulary_page.dart'
    as _i37;
import 'package:ar_zoo_explorers/features/vocabularydetail/presentation/vocabulary_detail_page.dart'
    as _i36;
import 'package:ar_zoo_explorers/features/welcome/presentation/welcome_page.dart'
    as _i38;
import 'package:ar_zoo_explorers/main_page.dart' as _i13;
import 'package:auto_route/auto_route.dart' as _i39;
import 'package:flutter/material.dart' as _i40;

abstract class $AppRouter extends _i39.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i39.PageFactory> pagesMap = {
    ARRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ARPage(),
      );
    },
    AccountManagerRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AccountManagerPage(),
      );
    },
    AnimalModelsRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AnimalModelsPage(),
      );
    },
    AppRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AppPage(),
      );
    },
    ChangLanguageRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ChangLanguagePage(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ChangePasswordPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ForgotPasswordPage(),
      );
    },
    HelpRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.HelpPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.HomePage(),
      );
    },
    LanguageSelectionRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LanguageSelectionPage(),
      );
    },
    LearningRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.LearningPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.MainPage(),
      );
    },
    ModelDetailRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.ModelDetailPage(),
      );
    },
    PhonicsDetailRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.PhonicsDetailPage(),
      );
    },
    PhonicsRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.PhonicsPage(),
      );
    },
    PuzzleRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.PuzzlePage(),
      );
    },
    PuzzleWordDetailRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.PuzzleWordDetailPage(),
      );
    },
    PuzzleWordRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.PuzzleWordPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.RegisterPage(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.ResetPasswordPage(),
      );
    },
    SearchModelRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.SearchModelPage(),
      );
    },
    SettingRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.SettingPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.SplashPage(),
      );
    },
    StoryFavoriteRoute.name: (routeData) {
      final args = routeData.argsAs<StoryFavoriteRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.StoryFavoritePage(
          key: args.key,
          toggleBottomBarVisibility: args.toggleBottomBarVisibility,
        ),
      );
    },
    StoryHomeRoute.name: (routeData) {
      final args = routeData.argsAs<StoryHomeRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i26.StoryHomePage(
          key: args.key,
          onPageChanged: args.onPageChanged,
          toggleBottomBarVisibility: args.toggleBottomBarVisibility,
        ),
      );
    },
    StoryListeningRoute.name: (routeData) {
      final args = routeData.argsAs<StoryListeningRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i27.StoryListeningPage(
          key: args.key,
          toggleBottomBarVisibility: args.toggleBottomBarVisibility,
        ),
      );
    },
    StoryOverviewRoute.name: (routeData) {
      final args = routeData.argsAs<StoryOverviewRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i28.StoryOverviewPage(
          key: args.key,
          onClosed: args.onClosed,
        ),
      );
    },
    StoryRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.StoryPage(),
      );
    },
    StoryPlayerRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.StoryPlayerPage(),
      );
    },
    StorySearchingRoute.name: (routeData) {
      final args = routeData.argsAs<StorySearchingRouteArgs>();
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i31.StorySearchingPage(
          key: args.key,
          toggleBottomBarVisibility: args.toggleBottomBarVisibility,
        ),
      );
    },
    StoryTopicRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.StoryTopicPage(),
      );
    },
    TermOfServiceRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.TermOfServicePage(),
      );
    },
    UserInformationRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i34.UserInformationPage(),
      );
    },
    UserProfileRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i35.UserProfilePage(),
      );
    },
    VocabularyDetailRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i36.VocabularyDetailPage(),
      );
    },
    VocabularyRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i37.VocabularyPage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i39.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i38.WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ARPage]
class ARRoute extends _i39.PageRouteInfo<void> {
  const ARRoute({List<_i39.PageRouteInfo>? children})
      : super(
          ARRoute.name,
          initialChildren: children,
        );

  static const String name = 'ARRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AccountManagerPage]
class AccountManagerRoute extends _i39.PageRouteInfo<void> {
  const AccountManagerRoute({List<_i39.PageRouteInfo>? children})
      : super(
          AccountManagerRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountManagerRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AnimalModelsPage]
class AnimalModelsRoute extends _i39.PageRouteInfo<void> {
  const AnimalModelsRoute({List<_i39.PageRouteInfo>? children})
      : super(
          AnimalModelsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnimalModelsRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AppPage]
class AppRoute extends _i39.PageRouteInfo<void> {
  const AppRoute({List<_i39.PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ChangLanguagePage]
class ChangLanguageRoute extends _i39.PageRouteInfo<void> {
  const ChangLanguageRoute({List<_i39.PageRouteInfo>? children})
      : super(
          ChangLanguageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangLanguageRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ChangePasswordPage]
class ChangePasswordRoute extends _i39.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i39.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ForgotPasswordPage]
class ForgotPasswordRoute extends _i39.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i39.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i8.HelpPage]
class HelpRoute extends _i39.PageRouteInfo<void> {
  const HelpRoute({List<_i39.PageRouteInfo>? children})
      : super(
          HelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i9.HomePage]
class HomeRoute extends _i39.PageRouteInfo<void> {
  const HomeRoute({List<_i39.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i10.LanguageSelectionPage]
class LanguageSelectionRoute extends _i39.PageRouteInfo<void> {
  const LanguageSelectionRoute({List<_i39.PageRouteInfo>? children})
      : super(
          LanguageSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageSelectionRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i11.LearningPage]
class LearningRoute extends _i39.PageRouteInfo<void> {
  const LearningRoute({List<_i39.PageRouteInfo>? children})
      : super(
          LearningRoute.name,
          initialChildren: children,
        );

  static const String name = 'LearningRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i12.LoginPage]
class LoginRoute extends _i39.PageRouteInfo<void> {
  const LoginRoute({List<_i39.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i13.MainPage]
class MainRoute extends _i39.PageRouteInfo<void> {
  const MainRoute({List<_i39.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i14.ModelDetailPage]
class ModelDetailRoute extends _i39.PageRouteInfo<void> {
  const ModelDetailRoute({List<_i39.PageRouteInfo>? children})
      : super(
          ModelDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'ModelDetailRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i15.PhonicsDetailPage]
class PhonicsDetailRoute extends _i39.PageRouteInfo<void> {
  const PhonicsDetailRoute({List<_i39.PageRouteInfo>? children})
      : super(
          PhonicsDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhonicsDetailRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i16.PhonicsPage]
class PhonicsRoute extends _i39.PageRouteInfo<void> {
  const PhonicsRoute({List<_i39.PageRouteInfo>? children})
      : super(
          PhonicsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhonicsRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i17.PuzzlePage]
class PuzzleRoute extends _i39.PageRouteInfo<void> {
  const PuzzleRoute({List<_i39.PageRouteInfo>? children})
      : super(
          PuzzleRoute.name,
          initialChildren: children,
        );

  static const String name = 'PuzzleRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i18.PuzzleWordDetailPage]
class PuzzleWordDetailRoute extends _i39.PageRouteInfo<void> {
  const PuzzleWordDetailRoute({List<_i39.PageRouteInfo>? children})
      : super(
          PuzzleWordDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'PuzzleWordDetailRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i19.PuzzleWordPage]
class PuzzleWordRoute extends _i39.PageRouteInfo<void> {
  const PuzzleWordRoute({List<_i39.PageRouteInfo>? children})
      : super(
          PuzzleWordRoute.name,
          initialChildren: children,
        );

  static const String name = 'PuzzleWordRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i20.RegisterPage]
class RegisterRoute extends _i39.PageRouteInfo<void> {
  const RegisterRoute({List<_i39.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i21.ResetPasswordPage]
class ResetPasswordRoute extends _i39.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i39.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i22.SearchModelPage]
class SearchModelRoute extends _i39.PageRouteInfo<void> {
  const SearchModelRoute({List<_i39.PageRouteInfo>? children})
      : super(
          SearchModelRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchModelRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i23.SettingPage]
class SettingRoute extends _i39.PageRouteInfo<void> {
  const SettingRoute({List<_i39.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i24.SplashPage]
class SplashRoute extends _i39.PageRouteInfo<void> {
  const SplashRoute({List<_i39.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i25.StoryFavoritePage]
class StoryFavoriteRoute extends _i39.PageRouteInfo<StoryFavoriteRouteArgs> {
  StoryFavoriteRoute({
    _i40.Key? key,
    required void Function() toggleBottomBarVisibility,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          StoryFavoriteRoute.name,
          args: StoryFavoriteRouteArgs(
            key: key,
            toggleBottomBarVisibility: toggleBottomBarVisibility,
          ),
          initialChildren: children,
        );

  static const String name = 'StoryFavoriteRoute';

  static const _i39.PageInfo<StoryFavoriteRouteArgs> page =
      _i39.PageInfo<StoryFavoriteRouteArgs>(name);
}

class StoryFavoriteRouteArgs {
  const StoryFavoriteRouteArgs({
    this.key,
    required this.toggleBottomBarVisibility,
  });

  final _i40.Key? key;

  final void Function() toggleBottomBarVisibility;

  @override
  String toString() {
    return 'StoryFavoriteRouteArgs{key: $key, toggleBottomBarVisibility: $toggleBottomBarVisibility}';
  }
}

/// generated route for
/// [_i26.StoryHomePage]
class StoryHomeRoute extends _i39.PageRouteInfo<StoryHomeRouteArgs> {
  StoryHomeRoute({
    _i40.Key? key,
    required dynamic Function(int) onPageChanged,
    required void Function() toggleBottomBarVisibility,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          StoryHomeRoute.name,
          args: StoryHomeRouteArgs(
            key: key,
            onPageChanged: onPageChanged,
            toggleBottomBarVisibility: toggleBottomBarVisibility,
          ),
          initialChildren: children,
        );

  static const String name = 'StoryHomeRoute';

  static const _i39.PageInfo<StoryHomeRouteArgs> page =
      _i39.PageInfo<StoryHomeRouteArgs>(name);
}

class StoryHomeRouteArgs {
  const StoryHomeRouteArgs({
    this.key,
    required this.onPageChanged,
    required this.toggleBottomBarVisibility,
  });

  final _i40.Key? key;

  final dynamic Function(int) onPageChanged;

  final void Function() toggleBottomBarVisibility;

  @override
  String toString() {
    return 'StoryHomeRouteArgs{key: $key, onPageChanged: $onPageChanged, toggleBottomBarVisibility: $toggleBottomBarVisibility}';
  }
}

/// generated route for
/// [_i27.StoryListeningPage]
class StoryListeningRoute extends _i39.PageRouteInfo<StoryListeningRouteArgs> {
  StoryListeningRoute({
    _i40.Key? key,
    required void Function() toggleBottomBarVisibility,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          StoryListeningRoute.name,
          args: StoryListeningRouteArgs(
            key: key,
            toggleBottomBarVisibility: toggleBottomBarVisibility,
          ),
          initialChildren: children,
        );

  static const String name = 'StoryListeningRoute';

  static const _i39.PageInfo<StoryListeningRouteArgs> page =
      _i39.PageInfo<StoryListeningRouteArgs>(name);
}

class StoryListeningRouteArgs {
  const StoryListeningRouteArgs({
    this.key,
    required this.toggleBottomBarVisibility,
  });

  final _i40.Key? key;

  final void Function() toggleBottomBarVisibility;

  @override
  String toString() {
    return 'StoryListeningRouteArgs{key: $key, toggleBottomBarVisibility: $toggleBottomBarVisibility}';
  }
}

/// generated route for
/// [_i28.StoryOverviewPage]
class StoryOverviewRoute extends _i39.PageRouteInfo<StoryOverviewRouteArgs> {
  StoryOverviewRoute({
    _i40.Key? key,
    required dynamic Function(String) onClosed,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          StoryOverviewRoute.name,
          args: StoryOverviewRouteArgs(
            key: key,
            onClosed: onClosed,
          ),
          initialChildren: children,
        );

  static const String name = 'StoryOverviewRoute';

  static const _i39.PageInfo<StoryOverviewRouteArgs> page =
      _i39.PageInfo<StoryOverviewRouteArgs>(name);
}

class StoryOverviewRouteArgs {
  const StoryOverviewRouteArgs({
    this.key,
    required this.onClosed,
  });

  final _i40.Key? key;

  final dynamic Function(String) onClosed;

  @override
  String toString() {
    return 'StoryOverviewRouteArgs{key: $key, onClosed: $onClosed}';
  }
}

/// generated route for
/// [_i29.StoryPage]
class StoryRoute extends _i39.PageRouteInfo<void> {
  const StoryRoute({List<_i39.PageRouteInfo>? children})
      : super(
          StoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoryRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i30.StoryPlayerPage]
class StoryPlayerRoute extends _i39.PageRouteInfo<void> {
  const StoryPlayerRoute({List<_i39.PageRouteInfo>? children})
      : super(
          StoryPlayerRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoryPlayerRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i31.StorySearchingPage]
class StorySearchingRoute extends _i39.PageRouteInfo<StorySearchingRouteArgs> {
  StorySearchingRoute({
    _i40.Key? key,
    required void Function() toggleBottomBarVisibility,
    List<_i39.PageRouteInfo>? children,
  }) : super(
          StorySearchingRoute.name,
          args: StorySearchingRouteArgs(
            key: key,
            toggleBottomBarVisibility: toggleBottomBarVisibility,
          ),
          initialChildren: children,
        );

  static const String name = 'StorySearchingRoute';

  static const _i39.PageInfo<StorySearchingRouteArgs> page =
      _i39.PageInfo<StorySearchingRouteArgs>(name);
}

class StorySearchingRouteArgs {
  const StorySearchingRouteArgs({
    this.key,
    required this.toggleBottomBarVisibility,
  });

  final _i40.Key? key;

  final void Function() toggleBottomBarVisibility;

  @override
  String toString() {
    return 'StorySearchingRouteArgs{key: $key, toggleBottomBarVisibility: $toggleBottomBarVisibility}';
  }
}

/// generated route for
/// [_i32.StoryTopicPage]
class StoryTopicRoute extends _i39.PageRouteInfo<void> {
  const StoryTopicRoute({List<_i39.PageRouteInfo>? children})
      : super(
          StoryTopicRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoryTopicRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i33.TermOfServicePage]
class TermOfServiceRoute extends _i39.PageRouteInfo<void> {
  const TermOfServiceRoute({List<_i39.PageRouteInfo>? children})
      : super(
          TermOfServiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermOfServiceRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i34.UserInformationPage]
class UserInformationRoute extends _i39.PageRouteInfo<void> {
  const UserInformationRoute({List<_i39.PageRouteInfo>? children})
      : super(
          UserInformationRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserInformationRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i35.UserProfilePage]
class UserProfileRoute extends _i39.PageRouteInfo<void> {
  const UserProfileRoute({List<_i39.PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i36.VocabularyDetailPage]
class VocabularyDetailRoute extends _i39.PageRouteInfo<void> {
  const VocabularyDetailRoute({List<_i39.PageRouteInfo>? children})
      : super(
          VocabularyDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'VocabularyDetailRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i37.VocabularyPage]
class VocabularyRoute extends _i39.PageRouteInfo<void> {
  const VocabularyRoute({List<_i39.PageRouteInfo>? children})
      : super(
          VocabularyRoute.name,
          initialChildren: children,
        );

  static const String name = 'VocabularyRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}

/// generated route for
/// [_i38.WelcomePage]
class WelcomeRoute extends _i39.PageRouteInfo<void> {
  const WelcomeRoute({List<_i39.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i39.PageInfo<void> page = _i39.PageInfo<void>(name);
}
