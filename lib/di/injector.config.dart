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

import '../app/app/app_cubit.dart' as _i4;
import '../app/config/app_config.dart' as _i3;
import '../app/managers/recognize_voice_manager.dart' as _i9;
import '../core/data/local_storage/local_storage.dart' as _i8;
import '../core/network/gpt_service/gpt_service.dart' as _i6;
import '../features/camera/presentation/camera_cubit.dart' as _i5;
import '../features/home/presentation/home_cubit.dart' as _i7;
import '../features/setting/presentation/setting_cubit.dart' as _i10;

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
  gh.singleton<_i3.AppConfig>(_i3.AppConfig());
  gh.singleton<_i4.AppCubit>(_i4.AppCubit());
  gh.factory<_i5.CameraCubit>(() => _i5.CameraCubit());
  gh.singleton<_i6.GptService>(_i6.GptService());
  gh.factory<_i7.HomeCubit>(() => _i7.HomeCubit());
  gh.singleton<_i8.LocalStorage>(_i8.LocalStorageImpl());
  gh.singleton<_i9.RecognizeVoiceManager>(_i9.RecognizeVoiceManager());
  gh.factory<_i10.SettingCubit>(() => _i10.SettingCubit());
  return getIt;
}
