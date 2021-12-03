// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../core/helpers/api_helper.dart' as _i3;
import '../core/helpers/navigation_helper.dart' as _i7;
import '../core/helpers/user_service.dart' as _i8;

import '../core/helpers/toast_helper.dart' as _i8;
import '../network/arena_api_service.dart' as _i4;
import '../network/games_api_service.dart' as _i5;
import '../network/leagues_api_service.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas
import '../network/teams_api_service.dart' as _i9;

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.ApiHelper>(() => _i3.ApiHelper());
  gh.lazySingleton<_i4.ArenasApiService>(() => _i4.ArenasApiService());
  gh.lazySingleton<_i5.GamesApiService>(() => _i5.GamesApiService());
  gh.lazySingleton<_i6.LeaguesApiService>(() => _i6.LeaguesApiService());
  gh.lazySingleton<_i7.NavigationHelper>(() => _i7.NavigationHelper());
  gh.lazySingleton<_i8.UserServiceViewModel>(() => _i8.UserServiceViewModel());
  gh.lazySingleton<_i9.TeamsApiService>(() => _i9.TeamsApiService());
  gh.lazySingleton<_i8.ToastHelper>(() => _i8.ToastHelper());
  return get;
}
