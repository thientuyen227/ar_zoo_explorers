// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app/app/app_cubit.dart' as _i7;
import '../app/config/app_config.dart' as _i6;
import '../app/managers/recognize_voice_manager.dart' as _i20;
<<<<<<< HEAD
import '../core/data/local_storage/local_storage.dart' as _i14;
import '../features/account/accountmanager/presentation/accountmanager_cubit.dart'
    as _i4;
import '../features/account/userinformation/presentation/userinformation_cubit.dart'
    as _i27;
import '../features/account/userprofile/presentation/userprofile_cubit.dart'
    as _i28;
=======
import '../core/data/local_storage/local_storage.dart' as _i16;
import '../features/account/accountmanager/presentation/accountmanager_cubit.dart'
    as _i4;
import '../features/account/userinformation/presentation/userinformation_cubit.dart'
    as _i31;
import '../features/account/userprofile/presentation/userprofile_cubit.dart'
    as _i32;
>>>>>>> origin/develop_minhtien
import '../features/animalmodels/presentation/animalmodels_cubit.dart' as _i5;
import '../features/ar/presentation/ar_cubit.dart' as _i3;
import '../features/authentication/changepassword/presentation/changepassword_cubit.dart'
    as _i9;
import '../features/authentication/forgotpassword/presentation/forgotpassword_cubit.dart'
    as _i10;
import '../features/authentication/login/presentation/login_cubit.dart' as _i17;
import '../features/authentication/register/presentation/register_cubit.dart'
    as _i21;
import '../features/authentication/resetpassword/presentation/resetpassword_cubit.dart'
    as _i22;
import '../features/authentication/termsofservice/presentation/termofservice_cubit.dart'
<<<<<<< HEAD
    as _i26;
=======
    as _i30;
>>>>>>> origin/develop_minhtien
import '../features/home/presentation/home_cubit.dart' as _i11;
import '../features/language/change_language_cubit.dart' as _i8;
import '../features/languageselection/presentation/languageselection_cubit.dart'
    as _i12;
import '../features/learning/presentation/learning_cubit.dart' as _i13;
<<<<<<< HEAD
import '../features/modeldetail/presentation/modeldetail_cubit.dart' as _i16;
import '../features/puzzle/puzzle_cubit.dart' as _i17;
import '../features/puzzleword/puzzle_word_cubit.dart' as _i18;
import '../features/puzzleworddetail/puzzle_word_detail_cubit.dart' as _i19;
import '../features/searchmodel/presentation/searchmodel_cubit.dart' as _i23;
import '../features/setting/presentation/setting_cubit.dart' as _i24;
import '../features/story/presentation/story_cubit.dart' as _i25;
import '../features/vocabulary/vocabulary_cubit.dart' as _i29;
import '../features/vocabularydetail/vocabulary_detail_cubit.dart' as _i30;
import '../features/welcome/presentation/welcome_cubit.dart' as _i31;
=======
import '../features/modeldetail/presentation/modeldetail_cubit.dart' as _i18;
import '../features/puzzle/puzzle_cubit.dart' as _i19;
import '../features/searchmodel/presentation/searchmodel_cubit.dart' as _i23;
import '../features/setting/presentation/setting_cubit.dart' as _i25;
import '../features/story/listening/presentation/listening_cubit.dart' as _i15;
import '../features/story/liststory/presentation/liststory_cubit.dart' as _i14;
import '../features/story/presentation/story_cubit.dart' as _i26;
import '../features/story/searchstory/presentation/searchstory_cubit.dart'
    as _i24;
import '../features/story/storyhome/presentation/storyhome_cubit.dart' as _i27;
import '../features/story/storyoverview/presentation/storyoverview_cubit.dart'
    as _i28;
import '../features/story/storyplayer/presentation/storyplayer_cubit.dart'
    as _i29;
import '../features/vocabulary/vocabulary_cubit.dart' as _i33;
import '../features/vocabularydetail/vocabulary_detail_cubit.dart' as _i34;
import '../features/welcome/presentation/welcome_cubit.dart' as _i35;
>>>>>>> origin/develop_minhtien

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetit(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.ARCubit>(() => _i3.ARCubit());
  gh.factory<_i4.AccountManagerCubit>(() => _i4.AccountManagerCubit());
  gh.factory<_i5.AnimalModelsCubit>(() => _i5.AnimalModelsCubit());
  gh.singleton<_i6.AppConfig>(_i6.AppConfig());
  gh.singleton<_i7.AppCubit>(_i7.AppCubit());
  gh.factory<_i8.ChangLanguageCubit>(() => _i8.ChangLanguageCubit());
  gh.factory<_i9.ChangePasswordCubit>(() => _i9.ChangePasswordCubit());
  gh.factory<_i10.ForgotPasswordCubit>(() => _i10.ForgotPasswordCubit());
  gh.factory<_i11.HomeCubit>(() => _i11.HomeCubit());
  gh.factory<_i12.LanguageSelectionCubit>(() => _i12.LanguageSelectionCubit());
  gh.factory<_i13.LearningCubit>(() => _i13.LearningCubit());
<<<<<<< HEAD
  gh.singleton<_i14.LocalStorage>(_i14.LocalStorageImpl());
  gh.factory<_i15.LoginCubit>(() => _i15.LoginCubit());
  gh.factory<_i16.ModelDetailCubit>(() => _i16.ModelDetailCubit());
  gh.factory<_i17.PuzzleCubit>(() => _i17.PuzzleCubit());
  gh.factory<_i18.PuzzleWordCubit>(() => _i18.PuzzleWordCubit());
  gh.factory<_i19.PuzzleWordDetailCubit>(() => _i19.PuzzleWordDetailCubit());
=======
  gh.factory<_i14.ListStoryCubit>(() => _i14.ListStoryCubit());
  gh.factory<_i15.ListeningCubit>(() => _i15.ListeningCubit());
  gh.singleton<_i16.LocalStorage>(_i16.LocalStorageImpl());
  gh.factory<_i17.LoginCubit>(() => _i17.LoginCubit());
  gh.factory<_i18.ModelDetailCubit>(() => _i18.ModelDetailCubit());
  gh.factory<_i19.PuzzleCubit>(() => _i19.PuzzleCubit());
>>>>>>> origin/develop_minhtien
  gh.singleton<_i20.RecognizeVoiceManager>(_i20.RecognizeVoiceManager());
  gh.factory<_i21.RegisterCubit>(() => _i21.RegisterCubit());
  gh.factory<_i22.ResetPasswordCubit>(() => _i22.ResetPasswordCubit());
  gh.factory<_i23.SearchModelCubit>(() => _i23.SearchModelCubit());
<<<<<<< HEAD
  gh.factory<_i24.SettingCubit>(() => _i24.SettingCubit());
  gh.factory<_i25.StoryCubit>(() => _i25.StoryCubit());
  gh.factory<_i26.TermOfServiceCubit>(() => _i26.TermOfServiceCubit());
  gh.factory<_i27.UserInformationCubit>(() => _i27.UserInformationCubit());
  gh.factory<_i28.UserProfileCubit>(() => _i28.UserProfileCubit());
  gh.factory<_i29.VocabularyCubit>(() => _i29.VocabularyCubit());
  gh.factory<_i30.VocabularyDetailCubit>(() => _i30.VocabularyDetailCubit());
  gh.factory<_i31.WelcomeCubit>(() => _i31.WelcomeCubit());
=======
  gh.factory<_i24.SearchStoryCubit>(() => _i24.SearchStoryCubit());
  gh.factory<_i25.SettingCubit>(() => _i25.SettingCubit());
  gh.factory<_i26.StoryCubit>(() => _i26.StoryCubit());
  gh.factory<_i27.StoryHomeCubit>(() => _i27.StoryHomeCubit());
  gh.factory<_i28.StoryOverviewCubit>(() => _i28.StoryOverviewCubit());
  gh.factory<_i29.StoryPlayerCubit>(() => _i29.StoryPlayerCubit());
  gh.factory<_i30.TermOfServiceCubit>(() => _i30.TermOfServiceCubit());
  gh.factory<_i31.UserInformationCubit>(() => _i31.UserInformationCubit());
  gh.factory<_i32.UserProfileCubit>(() => _i32.UserProfileCubit());
  gh.factory<_i33.VocabularyCubit>(() => _i33.VocabularyCubit());
  gh.factory<_i34.VocabularyDetailCubit>(() => _i34.VocabularyDetailCubit());
  gh.factory<_i35.WelcomeCubit>(() => _i35.WelcomeCubit());
>>>>>>> origin/develop_minhtien
  return getIt;
}
