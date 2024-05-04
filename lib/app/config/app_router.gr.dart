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
    as _i32;
import 'package:ar_zoo_explorers/features/account/userprofile/presentation/userprofile_page.dart'
    as _i33;
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
<<<<<<< HEAD
    as _i21;
import 'package:ar_zoo_explorers/features/authentication/resetpassword/presentation/resetpassword_page.dart'
    as _i22;
=======
    as _i18;
import 'package:ar_zoo_explorers/features/authentication/resetpassword/presentation/resetpassword_page.dart'
    as _i19;
>>>>>>> origin/develop_minhtien
import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_page.dart'
    as _i31;
import 'package:ar_zoo_explorers/features/help/presentation/help_page.dart'
    as _i8;
import 'package:ar_zoo_explorers/features/home/presentation/home_page.dart'
    as _i9;
import 'package:ar_zoo_explorers/features/language/change_language_page.dart'
    as _i5;
import 'package:ar_zoo_explorers/features/languageselection/presentation/languageselection_page.dart'
    as _i10;
import 'package:ar_zoo_explorers/features/learning/presentation/learning_page.dart'
    as _i11;
import 'package:ar_zoo_explorers/features/modeldetail/presentation/modeldetail_page.dart'
<<<<<<< HEAD
    as _i16;
import 'package:ar_zoo_explorers/features/phonics/phonics_page.dart' as _i17;
import 'package:ar_zoo_explorers/features/puzzle/puzzle_page.dart' as _i18;
import 'package:ar_zoo_explorers/features/puzzleword/puzzle_word_page.dart'
    as _i20;
import 'package:ar_zoo_explorers/features/puzzleworddetail/puzzle_word_detail_page.dart'
    as _i19;
import 'package:ar_zoo_explorers/features/searchmodel/presentation/searchmodel_page.dart'
    as _i23;
import 'package:ar_zoo_explorers/features/setting/presentation/setting_page.dart'
    as _i25;
import 'package:ar_zoo_explorers/features/splash/splash_page.dart' as _i26;
import 'package:ar_zoo_explorers/features/story/listening/presentation/listening_page.dart'
    as _i13;
import 'package:ar_zoo_explorers/features/story/liststory/presentation/liststory_page.dart'
    as _i12;
import 'package:ar_zoo_explorers/features/story/presentation/story_page.dart'
    as _i29;
import 'package:ar_zoo_explorers/features/story/searchstory/presentation/searchstory_page.dart'
    as _i24;
import 'package:ar_zoo_explorers/features/story/storyhome/presentation/storyhome_page.dart'
    as _i27;
import 'package:ar_zoo_explorers/features/story/storyoverview/presentation/storyoverview_page.dart'
    as _i28;
import 'package:ar_zoo_explorers/features/story/storyplayer/presentation/storyplayer_page.dart'
=======
    as _i14;
import 'package:ar_zoo_explorers/features/puzzle/puzzle_page.dart' as _i15;
import 'package:ar_zoo_explorers/features/puzzleword/puzzle_word_page.dart'
    as _i17;
import 'package:ar_zoo_explorers/features/puzzleworddetail/puzzle_word_detail_page.dart'
    as _i16;
import 'package:ar_zoo_explorers/features/searchmodel/presentation/searchmodel_page.dart'
    as _i20;
import 'package:ar_zoo_explorers/features/setting/presentation/setting_page.dart'
    as _i21;
import 'package:ar_zoo_explorers/features/splash/splash_page.dart' as _i22;
import 'package:ar_zoo_explorers/features/story/presentation/story_page.dart'
    as _i27;
import 'package:ar_zoo_explorers/features/storyfavorite/presentation/storyfavorite_page.dart'
    as _i23;
import 'package:ar_zoo_explorers/features/storyhome/presentation/storyhome_page.dart'
    as _i24;
import 'package:ar_zoo_explorers/features/storylistening/presentation/storylistening_page.dart'
    as _i25;
import 'package:ar_zoo_explorers/features/storyoverview/presentation/storyoverview_page.dart'
    as _i26;
import 'package:ar_zoo_explorers/features/storyplayer/presentation/storyplayer_page.dart'
    as _i28;
import 'package:ar_zoo_explorers/features/storysearching/presentation/storysearching_page.dart'
    as _i29;
import 'package:ar_zoo_explorers/features/storytopic/presentation/storytopic_page.dart'
>>>>>>> origin/develop_minhtien
    as _i30;
import 'package:ar_zoo_explorers/features/vocabulary/vocabulary_page.dart'
    as _i35;
import 'package:ar_zoo_explorers/features/vocabularydetail/vocabulary_detail_page.dart'
    as _i34;
import 'package:ar_zoo_explorers/features/welcome/presentation/welcome_page.dart'
    as _i36;
<<<<<<< HEAD
import 'package:ar_zoo_explorers/main_page.dart' as _i15;
=======
import 'package:ar_zoo_explorers/main_page.dart' as _i13;
>>>>>>> origin/develop_minhtien
import 'package:auto_route/auto_route.dart' as _i37;
import 'package:flutter/material.dart' as _i38;

abstract class $AppRouter extends _i37.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i37.PageFactory> pagesMap = {
    ARRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ARPage(),
      );
    },
    AccountManagerRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AccountManagerPage(),
      );
    },
    AnimalModelsRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AnimalModelsPage(),
      );
    },
    AppRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AppPage(),
      );
    },
    ChangLanguageRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.ChangLanguagePage(),
      );
    },
    ChangePasswordRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ChangePasswordPage(),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ForgotPasswordPage(),
      );
    },
    HelpRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.HelpPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.HomePage(),
      );
    },
    LanguageSelectionRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.LanguageSelectionPage(),
      );
    },
    LearningRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.LearningPage(),
      );
    },
<<<<<<< HEAD
    ListStoryRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.ListStoryPage(),
      );
    },
    ListeningRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.ListeningPage(),
      );
    },
=======
>>>>>>> origin/develop_minhtien
    LoginRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.LoginPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.MainPage(),
      );
    },
    ModelDetailRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.ModelDetailPage(),
      );
    },
<<<<<<< HEAD
    PhonicsRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.PhonicsPage(),
      );
    },
    PuzzleRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.PuzzlePage(),
=======
    PuzzleRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.PuzzlePage(),
>>>>>>> origin/develop_minhtien
      );
    },
    PuzzleWordDetailRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
<<<<<<< HEAD
        child: const _i19.PuzzleWordDetailPage(),
=======
        child: const _i16.PuzzleWordDetailPage(),
>>>>>>> origin/develop_minhtien
      );
    },
    PuzzleWordRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
<<<<<<< HEAD
        child: const _i20.PuzzleWordPage(),
=======
        child: const _i17.PuzzleWordPage(),
>>>>>>> origin/develop_minhtien
      );
    },
    RegisterRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
<<<<<<< HEAD
        child: const _i21.RegisterPage(),
=======
        child: const _i18.RegisterPage(),
>>>>>>> origin/develop_minhtien
      );
    },
    ResetPasswordRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
<<<<<<< HEAD
        child: const _i22.ResetPasswordPage(),
=======
        child: const _i19.ResetPasswordPage(),
>>>>>>> origin/develop_minhtien
      );
    },
    SearchModelRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
<<<<<<< HEAD
        child: const _i23.SearchModelPage(),
      );
    },
    SearchStoryRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.SearchStoryPage(),
=======
        child: const _i20.SearchModelPage(),
>>>>>>> origin/develop_minhtien
      );
    },
    SettingRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
<<<<<<< HEAD
        child: const _i25.SettingPage(),
=======
        child: const _i21.SettingPage(),
>>>>>>> origin/develop_minhtien
      );
    },
    SplashRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
<<<<<<< HEAD
        child: const _i26.SplashPage(),
=======
        child: const _i22.SplashPage(),
      );
    },
    StoryFavoriteRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.StoryFavoritePage(),
>>>>>>> origin/develop_minhtien
      );
    },
    StoryHomeRoute.name: (routeData) {
      final args = routeData.argsAs<StoryHomeRouteArgs>();
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
<<<<<<< HEAD
        child: _i27.StoryHomePage(
=======
        child: _i24.StoryHomePage(
>>>>>>> origin/develop_minhtien
          key: args.key,
          onPageChanged: args.onPageChanged,
        ),
      );
    },
<<<<<<< HEAD
    StoryOverviewRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.StoryOverviewPage(),
=======
    StoryListeningRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.StoryListeningPage(),
      );
    },
    StoryOverviewRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.StoryOverviewPage(),
>>>>>>> origin/develop_minhtien
      );
    },
    StoryRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
<<<<<<< HEAD
        child: const _i29.StoryPage(),
=======
        child: const _i27.StoryPage(),
>>>>>>> origin/develop_minhtien
      );
    },
    StoryPlayerRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
<<<<<<< HEAD
        child: const _i30.StoryPlayerPage(),
=======
        child: const _i28.StoryPlayerPage(),
      );
    },
    StorySearchingRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.StorySearchingPage(),
      );
    },
    StoryTopicRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.StoryTopicPage(),
>>>>>>> origin/develop_minhtien
      );
    },
    TermOfServiceRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.TermOfServicePage(),
      );
    },
    UserInformationRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.UserInformationPage(),
      );
    },
    UserProfileRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.UserProfilePage(),
      );
    },
    VocabularyDetailRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i34.VocabularyDetailPage(),
      );
    },
    VocabularyRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i35.VocabularyPage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i37.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i36.WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ARPage]
class ARRoute extends _i37.PageRouteInfo<void> {
  const ARRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ARRoute.name,
          initialChildren: children,
        );

  static const String name = 'ARRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AccountManagerPage]
class AccountManagerRoute extends _i37.PageRouteInfo<void> {
  const AccountManagerRoute({List<_i37.PageRouteInfo>? children})
      : super(
          AccountManagerRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountManagerRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AnimalModelsPage]
class AnimalModelsRoute extends _i37.PageRouteInfo<void> {
  const AnimalModelsRoute({List<_i37.PageRouteInfo>? children})
      : super(
          AnimalModelsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnimalModelsRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AppPage]
class AppRoute extends _i37.PageRouteInfo<void> {
  const AppRoute({List<_i37.PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ChangLanguagePage]
class ChangLanguageRoute extends _i37.PageRouteInfo<void> {
  const ChangLanguageRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ChangLanguageRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangLanguageRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ChangePasswordPage]
class ChangePasswordRoute extends _i37.PageRouteInfo<void> {
  const ChangePasswordRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ChangePasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePasswordRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ForgotPasswordPage]
class ForgotPasswordRoute extends _i37.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i8.HelpPage]
class HelpRoute extends _i37.PageRouteInfo<void> {
  const HelpRoute({List<_i37.PageRouteInfo>? children})
      : super(
          HelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i9.HomePage]
class HomeRoute extends _i37.PageRouteInfo<void> {
  const HomeRoute({List<_i37.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i10.LanguageSelectionPage]
class LanguageSelectionRoute extends _i37.PageRouteInfo<void> {
  const LanguageSelectionRoute({List<_i37.PageRouteInfo>? children})
      : super(
          LanguageSelectionRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageSelectionRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i11.LearningPage]
class LearningRoute extends _i37.PageRouteInfo<void> {
  const LearningRoute({List<_i37.PageRouteInfo>? children})
      : super(
          LearningRoute.name,
          initialChildren: children,
        );

  static const String name = 'LearningRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i12.ListStoryPage]
class ListStoryRoute extends _i37.PageRouteInfo<void> {
  const ListStoryRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ListStoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'ListStoryRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i13.ListeningPage]
class ListeningRoute extends _i37.PageRouteInfo<void> {
  const ListeningRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ListeningRoute.name,
          initialChildren: children,
        );

  static const String name = 'ListeningRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i14.LoginPage]
=======
/// [_i12.LoginPage]
>>>>>>> origin/develop_minhtien
class LoginRoute extends _i37.PageRouteInfo<void> {
  const LoginRoute({List<_i37.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i15.MainPage]
=======
/// [_i13.MainPage]
>>>>>>> origin/develop_minhtien
class MainRoute extends _i37.PageRouteInfo<void> {
  const MainRoute({List<_i37.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i16.ModelDetailPage]
=======
/// [_i14.ModelDetailPage]
>>>>>>> origin/develop_minhtien
class ModelDetailRoute extends _i37.PageRouteInfo<void> {
  const ModelDetailRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ModelDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'ModelDetailRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i17.PhonicsPage]
class PhonicsRoute extends _i37.PageRouteInfo<void> {
  const PhonicsRoute({List<_i37.PageRouteInfo>? children})
      : super(
          PhonicsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PhonicsRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i18.PuzzlePage]
=======
/// [_i15.PuzzlePage]
>>>>>>> origin/develop_minhtien
class PuzzleRoute extends _i37.PageRouteInfo<void> {
  const PuzzleRoute({List<_i37.PageRouteInfo>? children})
      : super(
          PuzzleRoute.name,
          initialChildren: children,
        );

  static const String name = 'PuzzleRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i19.PuzzleWordDetailPage]
=======
/// [_i16.PuzzleWordDetailPage]
>>>>>>> origin/develop_minhtien
class PuzzleWordDetailRoute extends _i37.PageRouteInfo<void> {
  const PuzzleWordDetailRoute({List<_i37.PageRouteInfo>? children})
      : super(
          PuzzleWordDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'PuzzleWordDetailRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i20.PuzzleWordPage]
=======
/// [_i17.PuzzleWordPage]
>>>>>>> origin/develop_minhtien
class PuzzleWordRoute extends _i37.PageRouteInfo<void> {
  const PuzzleWordRoute({List<_i37.PageRouteInfo>? children})
      : super(
          PuzzleWordRoute.name,
          initialChildren: children,
        );

  static const String name = 'PuzzleWordRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i21.RegisterPage]
=======
/// [_i18.RegisterPage]
>>>>>>> origin/develop_minhtien
class RegisterRoute extends _i37.PageRouteInfo<void> {
  const RegisterRoute({List<_i37.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i22.ResetPasswordPage]
=======
/// [_i19.ResetPasswordPage]
>>>>>>> origin/develop_minhtien
class ResetPasswordRoute extends _i37.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i37.PageRouteInfo>? children})
      : super(
          ResetPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i23.SearchModelPage]
=======
/// [_i20.SearchModelPage]
>>>>>>> origin/develop_minhtien
class SearchModelRoute extends _i37.PageRouteInfo<void> {
  const SearchModelRoute({List<_i37.PageRouteInfo>? children})
      : super(
          SearchModelRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchModelRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i24.SearchStoryPage]
class SearchStoryRoute extends _i37.PageRouteInfo<void> {
  const SearchStoryRoute({List<_i37.PageRouteInfo>? children})
      : super(
          SearchStoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchStoryRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i25.SettingPage]
=======
/// [_i21.SettingPage]
>>>>>>> origin/develop_minhtien
class SettingRoute extends _i37.PageRouteInfo<void> {
  const SettingRoute({List<_i37.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i26.SplashPage]
=======
/// [_i22.SplashPage]
>>>>>>> origin/develop_minhtien
class SplashRoute extends _i37.PageRouteInfo<void> {
  const SplashRoute({List<_i37.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i27.StoryHomePage]
=======
/// [_i23.StoryFavoritePage]
class StoryFavoriteRoute extends _i37.PageRouteInfo<void> {
  const StoryFavoriteRoute({List<_i37.PageRouteInfo>? children})
      : super(
          StoryFavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoryFavoriteRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i24.StoryHomePage]
>>>>>>> origin/develop_minhtien
class StoryHomeRoute extends _i37.PageRouteInfo<StoryHomeRouteArgs> {
  StoryHomeRoute({
    _i38.Key? key,
    required dynamic Function(int) onPageChanged,
    List<_i37.PageRouteInfo>? children,
  }) : super(
          StoryHomeRoute.name,
          args: StoryHomeRouteArgs(
            key: key,
            onPageChanged: onPageChanged,
          ),
          initialChildren: children,
        );

  static const String name = 'StoryHomeRoute';

  static const _i37.PageInfo<StoryHomeRouteArgs> page =
      _i37.PageInfo<StoryHomeRouteArgs>(name);
}

class StoryHomeRouteArgs {
  const StoryHomeRouteArgs({
    this.key,
    required this.onPageChanged,
  });

  final _i38.Key? key;

  final dynamic Function(int) onPageChanged;

  @override
  String toString() {
    return 'StoryHomeRouteArgs{key: $key, onPageChanged: $onPageChanged}';
  }
}

/// generated route for
<<<<<<< HEAD
/// [_i28.StoryOverviewPage]
=======
/// [_i25.StoryListeningPage]
class StoryListeningRoute extends _i37.PageRouteInfo<void> {
  const StoryListeningRoute({List<_i37.PageRouteInfo>? children})
      : super(
          StoryListeningRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoryListeningRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i26.StoryOverviewPage]
>>>>>>> origin/develop_minhtien
class StoryOverviewRoute extends _i37.PageRouteInfo<void> {
  const StoryOverviewRoute({List<_i37.PageRouteInfo>? children})
      : super(
          StoryOverviewRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoryOverviewRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i29.StoryPage]
=======
/// [_i27.StoryPage]
>>>>>>> origin/develop_minhtien
class StoryRoute extends _i37.PageRouteInfo<void> {
  const StoryRoute({List<_i37.PageRouteInfo>? children})
      : super(
          StoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoryRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
/// [_i30.StoryPlayerPage]
=======
/// [_i28.StoryPlayerPage]
>>>>>>> origin/develop_minhtien
class StoryPlayerRoute extends _i37.PageRouteInfo<void> {
  const StoryPlayerRoute({List<_i37.PageRouteInfo>? children})
      : super(
          StoryPlayerRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoryPlayerRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
<<<<<<< HEAD
=======
/// [_i29.StorySearchingPage]
class StorySearchingRoute extends _i37.PageRouteInfo<void> {
  const StorySearchingRoute({List<_i37.PageRouteInfo>? children})
      : super(
          StorySearchingRoute.name,
          initialChildren: children,
        );

  static const String name = 'StorySearchingRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i30.StoryTopicPage]
class StoryTopicRoute extends _i37.PageRouteInfo<void> {
  const StoryTopicRoute({List<_i37.PageRouteInfo>? children})
      : super(
          StoryTopicRoute.name,
          initialChildren: children,
        );

  static const String name = 'StoryTopicRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
>>>>>>> origin/develop_minhtien
/// [_i31.TermOfServicePage]
class TermOfServiceRoute extends _i37.PageRouteInfo<void> {
  const TermOfServiceRoute({List<_i37.PageRouteInfo>? children})
      : super(
          TermOfServiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermOfServiceRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i32.UserInformationPage]
class UserInformationRoute extends _i37.PageRouteInfo<void> {
  const UserInformationRoute({List<_i37.PageRouteInfo>? children})
      : super(
          UserInformationRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserInformationRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i33.UserProfilePage]
class UserProfileRoute extends _i37.PageRouteInfo<void> {
  const UserProfileRoute({List<_i37.PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i34.VocabularyDetailPage]
class VocabularyDetailRoute extends _i37.PageRouteInfo<void> {
  const VocabularyDetailRoute({List<_i37.PageRouteInfo>? children})
      : super(
          VocabularyDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'VocabularyDetailRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i35.VocabularyPage]
class VocabularyRoute extends _i37.PageRouteInfo<void> {
  const VocabularyRoute({List<_i37.PageRouteInfo>? children})
      : super(
          VocabularyRoute.name,
          initialChildren: children,
        );

  static const String name = 'VocabularyRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}

/// generated route for
/// [_i36.WelcomePage]
class WelcomeRoute extends _i37.PageRouteInfo<void> {
  const WelcomeRoute({List<_i37.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i37.PageInfo<void> page = _i37.PageInfo<void>(name);
}
