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
import '../app/managers/recognize_voice_manager.dart' as _i17;
import '../core/data/local_storage/local_storage.dart' as _i14;
import '../features/account/accountmanager/presentation/accountmanager_cubit.dart'
    as _i4;
import '../features/account/userinformation/presentation/userinformation_cubit.dart'
    as _i24;
import '../features/account/userprofile/presentation/userprofile_cubit.dart'
    as _i25;
import '../features/animalmodels/presentation/animalmodels_cubit.dart' as _i5;
import '../features/ar/presentation/ar_cubit.dart' as _i3;
import '../features/authentication/changepassword/presentation/changepassword_cubit.dart'
    as _i9;
import '../features/authentication/forgotpassword/presentation/forgotpassword_cubit.dart'
    as _i10;
import '../features/authentication/login/presentation/login_cubit.dart' as _i15;
import '../features/authentication/register/presentation/register_cubit.dart'
    as _i18;
import '../features/authentication/resetpassword/presentation/resetpassword_cubit.dart'
    as _i19;
import '../features/authentication/termsofservice/presentation/termofservice_cubit.dart'
    as _i23;
import '../features/home/presentation/home_cubit.dart' as _i11;
import '../features/language/change_language_cubit.dart' as _i8;
import '../features/languageselection/presentation/languageselection_cubit.dart'
    as _i12;
import '../features/learning/presentation/learning_cubit.dart' as _i13;
import '../features/modeldetail/presentation/modeldetail_cubit.dart' as _i16;
import '../features/searchmodel/presentation/searchmodel_cubit.dart' as _i20;
import '../features/setting/presentation/setting_cubit.dart' as _i21;
import '../features/story/presentation/story_cubit.dart' as _i22;
import '../features/welcome/presentation/welcome_cubit.dart' as _i26;

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
  gh.singleton<_i14.LocalStorage>(_i14.LocalStorageImpl());
  gh.factory<_i15.LoginCubit>(() => _i15.LoginCubit());
  gh.factory<_i16.ModelDetailCubit>(() => _i16.ModelDetailCubit());
  gh.singleton<_i17.RecognizeVoiceManager>(_i17.RecognizeVoiceManager());
  gh.factory<_i18.RegisterCubit>(() => _i18.RegisterCubit());
  gh.factory<_i19.ResetPasswordCubit>(() => _i19.ResetPasswordCubit());
  gh.factory<_i20.SearchModelCubit>(() => _i20.SearchModelCubit());
  gh.factory<_i21.SettingCubit>(() => _i21.SettingCubit());
  gh.factory<_i22.StoryCubit>(() => _i22.StoryCubit());
  gh.factory<_i23.TermOfServiceCubit>(() => _i23.TermOfServiceCubit());
  gh.factory<_i24.UserInformationCubit>(() => _i24.UserInformationCubit());
  gh.factory<_i25.UserProfileCubit>(() => _i25.UserProfileCubit());
  gh.factory<_i26.WelcomeCubit>(() => _i26.WelcomeCubit());
  return getIt;
}
