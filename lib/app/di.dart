import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/app/shared_preferences.dart';
import 'package:movies/movie_module/data/repository/repository_imp.dart';
import 'package:movies/movie_module/domain/repository/movie_repository.dart';
import 'package:movies/movie_module/domain/usecase/details_movie_usecase.dart';
import 'package:movies/movie_module/domain/usecase/playing_movies_usecase.dart';
import 'package:movies/movie_module/domain/usecase/popular_movies_usecase.dart';
import 'package:movies/movie_module/domain/usecase/recommendations_usecase.dart';
import 'package:movies/movie_module/domain/usecase/top_rating_movies_usecase.dart';
import 'package:movies/movie_module/pressentation/controller/movie_details_bloc/movie_details_bloc.dart';
import 'package:movies/tv_module/domain/usecase/popular_tv_usecase.dart';
import 'package:movies/tv_module/domain/usecase/top_ratted_tv_usecase.dart';
import 'package:movies/tv_module/domain/usecase/tv_season_usecase.dart';
import 'package:movies/tv_module/pressentation/controller/episode_bloc/episode_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../movie_module/data/datasource/remote_datasource.dart';
import '../movie_module/pressentation/controller/movies_bloc/movies_bloc.dart';
import '../setting_module/controller/setting_bloc.dart';
import '../tv_module/data/datasource/remote_datasource.dart';
import '../tv_module/data/repository/repository_imp.dart';
import '../tv_module/domain/repository/repository.dart';
import '../tv_module/domain/usecase/on_air_usecase.dart';
import '../tv_module/domain/usecase/recommendation_tv_usecase.dart';
import '../tv_module/domain/usecase/tv_details_usecase.dart';
import '../tv_module/pressentation/controller/details_tv_bloc/details_tv_bloc.dart';
import '../tv_module/pressentation/controller/tv_bloc/tv_bloc.dart';


final instance = GetIt.instance;

Future<void> initAppModule() async{

  // shared preferences instance
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // app prefs instance
  instance.registerLazySingleton<AppPrefs>(() => AppPrefs(instance()));

  // remote data source
  instance.registerLazySingleton<BaseRemoteDataSource>(() => RemoteDataSource());
  instance.registerLazySingleton<BaseTvRemoteDataSource>(() => TvRemoteDataSource());


  // repository
  instance.registerLazySingleton<BaseMoviesRepository>(() => RepositoryImp(instance()));
  instance.registerLazySingleton<BaseTvRepository>(() => TvRepositoryImp(instance()));


  // use case
  instance.registerFactory<GetPlayingMoviesUseCase>(() => GetPlayingMoviesUseCase(instance()));
  instance.registerFactory<GetPopularMoviesUseCase>(() => GetPopularMoviesUseCase(instance()));
  instance.registerFactory<GetTopRatingMoviesUseCase>(() => GetTopRatingMoviesUseCase(instance()));
  instance.registerFactory<GetMovieDetailsUseCase>(() => GetMovieDetailsUseCase(instance()));
  instance.registerFactory<GetRecommendationMoviesUseCase>(() => GetRecommendationMoviesUseCase(instance()));
  instance.registerFactory<GetOnAirUseCase>(() => GetOnAirUseCase(instance()));
  instance.registerFactory<GetPopularTvUseCase>(() => GetPopularTvUseCase(instance()));
  instance.registerFactory<GetTopRattedTvUseCase>(() => GetTopRattedTvUseCase(instance()));
  instance.registerFactory<GetTvDetailsUseCase>(() => GetTvDetailsUseCase(instance()));
  instance.registerFactory<GetRecommendationTvsUseCase>(() => GetRecommendationTvsUseCase(instance()));
  instance.registerFactory<GetSeasonTvUseCase>(() => GetSeasonTvUseCase(instance()));

  //bloc
  instance.registerFactory(() => MovieBloc(instance(),instance(),instance()));
  instance.registerFactory(() => MovieDetailsBloc(instance(),instance()));
  instance.registerFactory(() => TvBloc(instance(),instance(),instance()));
  instance.registerFactory(() => DetailsTvBloc(instance(),instance()));
  instance.registerFactory(() => EpisodeBloc(instance()));
  instance.registerFactory(() => SettingBloc());





}