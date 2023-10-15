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

import '../app/app/app_cubit.dart' as _i5;
import '../app/config/app_config.dart' as _i4;
import '../app/managers/recognize_voice_manager.dart' as _i11;
import '../core/data/local_storage/local_storage.dart' as _i9;
import '../core/network/gpt_service/gpt_service.dart' as _i6;
import '../features/ar/presentation/ar_cubit.dart' as _i3;
import '../features/authentication/information/presentation/information_cubit.dart'
    as _i8;
import '../features/authentication/login/presentation/login_cubit.dart' as _i10;
import '../features/authentication/register/presentation/register_cubit.dart'
    as _i12;
import '../features/authentication/termsofservice/presentation/termofservice_cubit.dart'
    as _i14;
import '../features/home/presentation/home_cubit.dart' as _i7;
import '../features/setting/presentation/setting_cubit.dart' as _i13;
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
  gh.singleton<_i4.AppConfig>(_i4.AppConfig());
  gh.singleton<_i5.AppCubit>(_i5.AppCubit());
  gh.singleton<_i6.GptService>(_i6.GptService());
  gh.factory<_i7.HomeCubit>(() => _i7.HomeCubit());
  gh.factory<_i8.InformationCubit>(() => _i8.InformationCubit());
  gh.singleton<_i9.LocalStorage>(_i9.LocalStorageImpl());
  gh.factory<_i10.LoginCubit>(() => _i10.LoginCubit());
  gh.singleton<_i11.RecognizeVoiceManager>(_i11.RecognizeVoiceManager());
  gh.factory<_i12.RegisterCubit>(() => _i12.RegisterCubit());
  gh.factory<_i13.SettingCubit>(() => _i13.SettingCubit());
  gh.factory<_i14.TermOfServiceCubit>(() => _i14.TermOfServiceCubit());
  gh.factory<_i15.WelcomeCubit>(() => _i15.WelcomeCubit());
  return getIt;
}
