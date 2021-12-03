// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:mvp/core/helpers/api_helper.dart';
import 'package:mvp/core/helpers/navigation_helper.dart';
import 'package:mvp/core/helpers/toast_helper.dart';

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<ApiHelper>(() => ApiHelper());
  // gh.lazySingleton<_i4.ArenasApiService>(() => _i4.ArenasApiService());
  // gh.lazySingleton<_i5.GamesApiService>(() => _i5.GamesApiService());
  // gh.lazySingleton<_i6.LeaguesApiService>(() => _i6.LeaguesApiService());
  gh.lazySingleton<NavigationHelper>(() => NavigationHelper());
  // gh.lazySingleton<_i8.UserServiceViewModel>(() => _i8.UserServiceViewModel());

  gh.lazySingleton<ToastHelper>(() => ToastHelper());
  return get;
}
