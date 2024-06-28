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
import '../app/managers/recognize_voice_manager.dart' as _i23;
import '../core/data/local_storage/local_storage.dart' as _i15;
import '../features/account/accountmanager/presentation/accountmanager_cubit.dart'
    as _i4;
import '../features/account/userinformation/presentation/userinformation_cubit.dart'
    as _i37;
import '../features/account/userprofile/presentation/userprofile_cubit.dart'
    as _i38;
import '../features/animalmodels/presentation/animalmodels_cubit.dart' as _i5;
import '../features/ar/presentation/ar_cubit.dart' as _i3;
import '../features/authentication/changepassword/presentation/changepassword_cubit.dart'
    as _i9;
import '../features/authentication/forgotpassword/presentation/forgotpassword_cubit.dart'
    as _i11;
import '../features/authentication/login/presentation/login_cubit.dart' as _i16;
import '../features/authentication/register/presentation/register_cubit.dart'
    as _i24;
import '../features/authentication/resetpassword/presentation/resetpassword_cubit.dart'
    as _i25;
import '../features/authentication/termsofservice/presentation/termofservice_cubit.dart'
    as _i36;
import '../features/chatAI/presentation/chat_ai_cubit.dart' as _i10;
import '../features/home/presentation/home_cubit.dart' as _i12;
import '../features/language/presentation/change_language_cubit.dart' as _i8;
import '../features/languageselection/presentation/languageselection_cubit.dart'
    as _i13;
import '../features/learning/presentation/learning_cubit.dart' as _i14;
import '../features/modeldetail/presentation/modeldetail_cubit.dart' as _i17;
import '../features/phonics/presentation/phonics_cubit.dart' as _i18;
import '../features/phonicsdetail/presentation/phonics_detail_cubit.dart'
    as _i19;
import '../features/puzzle/presentation/puzzle_cubit.dart' as _i20;
import '../features/puzzleword/presentation/puzzle_word_cubit.dart' as _i21;
import '../features/puzzleworddetail/presentation/puzzle_word_detail_cubit.dart'
    as _i22;
import '../features/searchmodel/presentation/searchmodel_cubit.dart' as _i26;
import '../features/setting/presentation/setting_cubit.dart' as _i27;
import '../features/story/presentation/story_cubit.dart' as _i28;
import '../features/storyfavorite/presentation/storyfavorite_cubit.dart'
    as _i29;
import '../features/storyhome/presentation/storyhome_cubit.dart' as _i30;
import '../features/storylistening/presentation/storylistening_cubit.dart'
    as _i31;
import '../features/storyoverview/presentation/storyoverview_cubit.dart'
    as _i32;
import '../features/storyplayer/presentation/storyplayer_cubit.dart' as _i33;
import '../features/storysearching/presentation/storysearching_cubit.dart'
    as _i34;
import '../features/storytopic/presentation/storytopic_cubit.dart' as _i35;
import '../features/vocabulary/presentation/vocabulary_cubit.dart' as _i39;
import '../features/vocabularydetail/presentation/vocabulary_detail_cubit.dart'
    as _i40;
import '../features/welcome/presentation/welcome_cubit.dart' as _i41;
import '../features/writingpractice/presentation/writing_practice_cubit.dart'
    as _i42;
import '../features/writingpracticedetail/presentation/writing_practice_detail_cubit.dart'
    as _i43;

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
  gh.factory<_i10.ChatAICubit>(() => _i10.ChatAICubit());
  gh.factory<_i11.ForgotPasswordCubit>(() => _i11.ForgotPasswordCubit());
  gh.factory<_i12.HomeCubit>(() => _i12.HomeCubit());
  gh.factory<_i13.LanguageSelectionCubit>(() => _i13.LanguageSelectionCubit());
  gh.factory<_i14.LearningCubit>(() => _i14.LearningCubit());
  gh.singleton<_i15.LocalStorage>(_i15.LocalStorageImpl());
  gh.factory<_i16.LoginCubit>(() => _i16.LoginCubit());
  gh.factory<_i17.ModelDetailCubit>(() => _i17.ModelDetailCubit());
  gh.factory<_i18.PhonicsCubit>(() => _i18.PhonicsCubit());
  gh.factory<_i19.PhonicsDetailCubit>(() => _i19.PhonicsDetailCubit());
  gh.factory<_i20.PuzzleCubit>(() => _i20.PuzzleCubit());
  gh.factory<_i21.PuzzleWordCubit>(() => _i21.PuzzleWordCubit());
  gh.factory<_i22.PuzzleWordDetailCubit>(() => _i22.PuzzleWordDetailCubit());
  gh.singleton<_i23.RecognizeVoiceManager>(_i23.RecognizeVoiceManager());
  gh.factory<_i24.RegisterCubit>(() => _i24.RegisterCubit());
  gh.factory<_i25.ResetPasswordCubit>(() => _i25.ResetPasswordCubit());
  gh.factory<_i26.SearchModelCubit>(() => _i26.SearchModelCubit());
  gh.factory<_i27.SettingCubit>(() => _i27.SettingCubit());
  gh.factory<_i28.StoryCubit>(() => _i28.StoryCubit());
  gh.factory<_i29.StoryFavoriteCubit>(() => _i29.StoryFavoriteCubit());
  gh.factory<_i30.StoryHomeCubit>(() => _i30.StoryHomeCubit());
  gh.factory<_i31.StoryListeningCubit>(() => _i31.StoryListeningCubit());
  gh.factory<_i32.StoryOverviewCubit>(() => _i32.StoryOverviewCubit());
  gh.factory<_i33.StoryPlayerCubit>(() => _i33.StoryPlayerCubit());
  gh.factory<_i34.StorySearchingCubit>(() => _i34.StorySearchingCubit());
  gh.factory<_i35.StoryTopicCubit>(() => _i35.StoryTopicCubit());
  gh.factory<_i36.TermOfServiceCubit>(() => _i36.TermOfServiceCubit());
  gh.factory<_i37.UserInformationCubit>(() => _i37.UserInformationCubit());
  gh.factory<_i38.UserProfileCubit>(() => _i38.UserProfileCubit());
  gh.factory<_i39.VocabularyCubit>(() => _i39.VocabularyCubit());
  gh.factory<_i40.VocabularyDetailCubit>(() => _i40.VocabularyDetailCubit());
  gh.factory<_i41.WelcomeCubit>(() => _i41.WelcomeCubit());
  gh.factory<_i42.WritingPracticeCubit>(() => _i42.WritingPracticeCubit());
  gh.factory<_i43.WritingPracticeDetailCubit>(
      () => _i43.WritingPracticeDetailCubit());
  return getIt;
}
