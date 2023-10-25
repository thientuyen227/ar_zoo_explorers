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

import '../app/app/app_cubit.dart' as _i6;
import '../app/config/app_config.dart' as _i5;
import '../app/managers/recognize_voice_manager.dart' as _i10;
import '../core/data/local_storage/local_storage.dart' as _i8;
import '../features/account/accountmanager/presentation/accountmanager_cubit.dart'
    as _i4;
import '../features/account/userprofile/presentation/userprofile_cubit.dart'
    as _i14;
import '../features/ar/presentation/ar_cubit.dart' as _i3;
import '../features/authentication/login/presentation/login_cubit.dart' as _i9;
import '../features/authentication/register/presentation/register_cubit.dart'
    as _i11;
import '../features/authentication/termsofservice/presentation/termofservice_cubit.dart'
    as _i13;
import '../features/home/presentation/home_cubit.dart' as _i7;
import '../features/setting/presentation/setting_cubit.dart' as _i12;
import '../features/welcome/presentation/welcome_cubit.dart' as _i15;

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
  gh.singleton<_i5.AppConfig>(_i5.AppConfig());
  gh.singleton<_i6.AppCubit>(_i6.AppCubit());
  gh.factory<_i7.HomeCubit>(() => _i7.HomeCubit());
  gh.singleton<_i8.LocalStorage>(_i8.LocalStorageImpl());
  gh.factory<_i9.LoginCubit>(() => _i9.LoginCubit());
  gh.singleton<_i10.RecognizeVoiceManager>(_i10.RecognizeVoiceManager());
  gh.factory<_i11.RegisterCubit>(() => _i11.RegisterCubit());
  gh.factory<_i12.SettingCubit>(() => _i12.SettingCubit());
  gh.factory<_i13.TermOfServiceCubit>(() => _i13.TermOfServiceCubit());
  gh.factory<_i14.UserProfileCubit>(() => _i14.UserProfileCubit());
  gh.factory<_i15.WelcomeCubit>(() => _i15.WelcomeCubit());
  return getIt;
}
