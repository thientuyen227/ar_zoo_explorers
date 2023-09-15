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
import '../app/managers/recognize_voice_manager.dart' as _i10;
import '../core/data/local_storage/local_storage.dart' as _i9;
import '../core/network/gpt_service/gpt_service.dart' as _i7;
import '../features/ar/presentation/ar_cubit.dart' as _i3;
import '../features/camera/presentation/camera_cubit.dart' as _i6;
import '../features/home/presentation/home_cubit.dart' as _i8;
import '../features/setting/presentation/setting_cubit.dart' as _i11;

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
  gh.factory<_i6.CameraCubit>(() => _i6.CameraCubit());
  gh.singleton<_i7.GptService>(_i7.GptService());
  gh.factory<_i8.HomeCubit>(() => _i8.HomeCubit());
  gh.singleton<_i9.LocalStorage>(_i9.LocalStorageImpl());
  gh.singleton<_i10.RecognizeVoiceManager>(_i10.RecognizeVoiceManager());
  gh.factory<_i11.SettingCubit>(() => _i11.SettingCubit());
  return getIt;
}
