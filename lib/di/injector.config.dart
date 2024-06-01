// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../app/app/app_cubit.dart' as _i38;
import '../app/config/app_config.dart' as _i39;
import '../app/managers/recognize_voice_manager.dart' as _i40;
import '../core/data/local_storage/local_storage.dart' as _i41;
import '../features/account/accountmanager/presentation/accountmanager_cubit.dart'
    as _i3;
import '../features/account/userinformation/presentation/userinformation_cubit.dart'
    as _i4;
import '../features/account/userprofile/presentation/userprofile_cubit.dart'
    as _i5;
import '../features/animalmodels/presentation/animalmodels_cubit.dart' as _i6;
import '../features/ar/presentation/ar_cubit.dart' as _i7;
import '../features/authentication/changepassword/presentation/changepassword_cubit.dart'
    as _i8;
import '../features/authentication/forgotpassword/presentation/forgotpassword_cubit.dart'
    as _i9;
import '../features/authentication/login/presentation/login_cubit.dart' as _i10;
import '../features/authentication/register/presentation/register_cubit.dart'
    as _i11;
import '../features/authentication/resetpassword/presentation/resetpassword_cubit.dart'
    as _i12;
import '../features/authentication/termsofservice/presentation/termofservice_cubit.dart'
    as _i13;
import '../features/chatAI/presentation/chat_ai_cubit.dart' as _i14;
import '../features/home/presentation/home_cubit.dart' as _i15;
import '../features/language/presentation/change_language_cubit.dart' as _i16;
import '../features/languageselection/presentation/languageselection_cubit.dart'
    as _i17;
import '../features/learning/presentation/learning_cubit.dart' as _i18;
import '../features/modeldetail/presentation/modeldetail_cubit.dart' as _i19;
import '../features/phonics/presentation/phonics_cubit.dart' as _i20;
import '../features/phonicsdetail/presentation/phonics_detail_cubit.dart'
    as _i21;
import '../features/puzzle/presentation/puzzle_cubit.dart' as _i22;
import '../features/puzzleword/presentation/puzzle_word_cubit.dart' as _i23;
import '../features/puzzleworddetail/presentation/puzzle_word_detail_cubit.dart'
    as _i24;
import '../features/searchmodel/presentation/searchmodel_cubit.dart' as _i25;
import '../features/setting/presentation/setting_cubit.dart' as _i26;
import '../features/story/presentation/story_cubit.dart' as _i27;
import '../features/storyfavorite/presentation/storyfavorite_cubit.dart'
    as _i28;
import '../features/storyhome/presentation/storyhome_cubit.dart' as _i29;
import '../features/storylistening/presentation/storylistening_cubit.dart'
    as _i30;
import '../features/storyoverview/presentation/storyoverview_cubit.dart'
    as _i31;
import '../features/storyplayer/presentation/storyplayer_cubit.dart' as _i32;
import '../features/storysearching/presentation/storysearching_cubit.dart'
    as _i33;
import '../features/storytopic/presentation/storytopic_cubit.dart' as _i34;
import '../features/vocabulary/presentation/vocabulary_cubit.dart' as _i35;
import '../features/vocabularydetail/presentation/vocabulary_detail_cubit.dart'
    as _i36;
import '../features/welcome/presentation/welcome_cubit.dart' as _i37;

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
  gh.factory<_i3.AccountManagerCubit>(() => _i3.AccountManagerCubit());
  gh.factory<_i4.UserInformationCubit>(() => _i4.UserInformationCubit());
  gh.factory<_i5.UserProfileCubit>(() => _i5.UserProfileCubit());
  gh.factory<_i6.AnimalModelsCubit>(() => _i6.AnimalModelsCubit());
  gh.factory<_i7.ARCubit>(() => _i7.ARCubit());
  gh.factory<_i8.ChangePasswordCubit>(() => _i8.ChangePasswordCubit());
  gh.factory<_i9.ForgotPasswordCubit>(() => _i9.ForgotPasswordCubit());
  gh.factory<_i10.LoginCubit>(() => _i10.LoginCubit());
  gh.factory<_i11.RegisterCubit>(() => _i11.RegisterCubit());
  gh.factory<_i12.ResetPasswordCubit>(() => _i12.ResetPasswordCubit());
  gh.factory<_i13.TermOfServiceCubit>(() => _i13.TermOfServiceCubit());
  gh.factory<_i14.ChatAICubit>(() => _i14.ChatAICubit());
  gh.factory<_i15.HomeCubit>(() => _i15.HomeCubit());
  gh.factory<_i16.ChangLanguageCubit>(() => _i16.ChangLanguageCubit());
  gh.factory<_i17.LanguageSelectionCubit>(() => _i17.LanguageSelectionCubit());
  gh.factory<_i18.LearningCubit>(() => _i18.LearningCubit());
  gh.factory<_i19.ModelDetailCubit>(() => _i19.ModelDetailCubit());
  gh.factory<_i20.PhonicsCubit>(() => _i20.PhonicsCubit());
  gh.factory<_i21.PhonicsDetailCubit>(() => _i21.PhonicsDetailCubit());
  gh.factory<_i22.PuzzleCubit>(() => _i22.PuzzleCubit());
  gh.factory<_i23.PuzzleWordCubit>(() => _i23.PuzzleWordCubit());
  gh.factory<_i24.PuzzleWordDetailCubit>(() => _i24.PuzzleWordDetailCubit());
  gh.factory<_i25.SearchModelCubit>(() => _i25.SearchModelCubit());
  gh.factory<_i26.SettingCubit>(() => _i26.SettingCubit());
  gh.factory<_i27.StoryCubit>(() => _i27.StoryCubit());
  gh.factory<_i28.StoryFavoriteCubit>(() => _i28.StoryFavoriteCubit());
  gh.factory<_i29.StoryHomeCubit>(() => _i29.StoryHomeCubit());
  gh.factory<_i30.StoryListeningCubit>(() => _i30.StoryListeningCubit());
  gh.factory<_i31.StoryOverviewCubit>(() => _i31.StoryOverviewCubit());
  gh.factory<_i32.StoryPlayerCubit>(() => _i32.StoryPlayerCubit());
  gh.factory<_i33.StorySearchingCubit>(() => _i33.StorySearchingCubit());
  gh.factory<_i34.StoryTopicCubit>(() => _i34.StoryTopicCubit());
  gh.factory<_i35.VocabularyCubit>(() => _i35.VocabularyCubit());
  gh.factory<_i36.VocabularyDetailCubit>(() => _i36.VocabularyDetailCubit());
  gh.factory<_i37.WelcomeCubit>(() => _i37.WelcomeCubit());
  gh.singleton<_i38.AppCubit>(() => _i38.AppCubit());
  gh.singleton<_i39.AppConfig>(() => _i39.AppConfig());
  gh.singleton<_i40.RecognizeVoiceManager>(() => _i40.RecognizeVoiceManager());
  gh.singleton<_i41.LocalStorage>(() => _i41.LocalStorageImpl());
  return getIt;
}
