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
import '../app/managers/recognize_voice_manager.dart' as _i14;
import '../core/data/local_storage/local_storage.dart' as _i11;
import '../features/account/accountmanager/presentation/accountmanager_cubit.dart'
    as _i4;
import '../features/account/userinformation/presentation/userinformation_cubit.dart'
    as _i19;
import '../features/account/userprofile/presentation/userprofile_cubit.dart'
    as _i20;
import '../features/animalmodels/presentation/animalmodels_cubit.dart' as _i5;
import '../features/ar/presentation/ar_cubit.dart' as _i3;
import '../features/authentication/changepassword/presentation/changepassword_cubit.dart'
    as _i8;
import '../features/authentication/forgotpassword/presentation/forgotpassword_cubit.dart'
    as _i9;
import '../features/authentication/login/presentation/login_cubit.dart' as _i12;
import '../features/authentication/register/presentation/register_cubit.dart'
    as _i15;
import '../features/authentication/resetpassword/presentation/resetpassword_cubit.dart'
    as _i16;
import '../features/authentication/termsofservice/presentation/termofservice_cubit.dart'
    as _i18;
import '../features/home/presentation/home_cubit.dart' as _i10;
import '../features/modleldetail/presentation/modeldetail_cubit.dart' as _i13;
import '../features/setting/presentation/setting_cubit.dart' as _i17;
import '../features/welcome/presentation/welcome_cubit.dart' as _i21;

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
  gh.factory<_i8.ChangePasswordCubit>(() => _i8.ChangePasswordCubit());
  gh.factory<_i9.ForgotPasswordCubit>(() => _i9.ForgotPasswordCubit());
  gh.factory<_i10.HomeCubit>(() => _i10.HomeCubit());
  gh.singleton<_i11.LocalStorage>(_i11.LocalStorageImpl());
  gh.factory<_i12.LoginCubit>(() => _i12.LoginCubit());
  gh.factory<_i13.ModelDetailCubit>(() => _i13.ModelDetailCubit());
  gh.singleton<_i14.RecognizeVoiceManager>(_i14.RecognizeVoiceManager());
  gh.factory<_i15.RegisterCubit>(() => _i15.RegisterCubit());
  gh.factory<_i16.ResetPasswordCubit>(() => _i16.ResetPasswordCubit());
  gh.factory<_i17.SettingCubit>(() => _i17.SettingCubit());
  gh.factory<_i18.TermOfServiceCubit>(() => _i18.TermOfServiceCubit());
  gh.factory<_i19.UserInformationCubit>(() => _i19.UserInformationCubit());
  gh.factory<_i20.UserProfileCubit>(() => _i20.UserProfileCubit());
  gh.factory<_i21.WelcomeCubit>(() => _i21.WelcomeCubit());
  return getIt;
}
