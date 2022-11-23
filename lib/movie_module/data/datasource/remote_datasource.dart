import 'package:dio/dio.dart';
import 'package:movies/app/Network/error_model.dart';
import 'package:movies/app/resource/constants.dart';
import 'package:movies/app/error/exception.dart';
import 'package:movies/movie_module/data/models/movie_details_model.dart';
import 'package:movies/movie_module/domain/usecase/details_movie_usecase.dart';

import '../../domain/usecase/recommendations_usecase.dart';
import '../models/Movie_model.dart';
import '../models/recommendation_movie_model.dart';

abstract class BaseRemoteDataSource {
  Future<List<MovieModel>> getPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatingMovies();
  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParameter parameter);
  Future<List<RecommendationMovieModel>> getRecommendationMovies(RecommendationMovieParameter parameter);


}

class RemoteDataSource implements BaseRemoteDataSource{
  @override
  Future<List<MovieModel>> getPlayingMovies() async {
    final response= await Dio().get(AppConstants.getPlayingMoviesPath());
    if(response.statusCode == 200){
      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e)));
    }
    else{
      throw(
          ServerException(errorModel: ErrorModel.fromJson(response.data))
      );
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response= await Dio().get(AppConstants.getPopularMoviesPath());
    if(response.statusCode == 200){
      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e)));
    }
    else{
      throw(
          ServerException(errorModel: ErrorModel.fromJson(response.data))
      );
    }
  }

  @override
  Future<List<MovieModel>> getTopRatingMovies() async {
    final response= await Dio().get(AppConstants.getTopRatingMoviesPath());
    if(response.statusCode == 200){
      return List<MovieModel>.from((response.data["results"]as List).map((e) => MovieModel.fromJson(e)));
    }
    else{
      throw(
          ServerException(errorModel: ErrorModel.fromJson(response.data))
      );
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParameter parameter) async {
    final response= await Dio().get(AppConstants.getMovieDetailsPath(parameter.id));
    if(response.statusCode == 200){
      return MovieDetailsModel.fromJson(response.data);
    }
    else{
      throw(
          ServerException(errorModel: ErrorModel.fromJson(response.data))
      );
    }
  }

  @override
  Future<List<RecommendationMovieModel>> getRecommendationMovies(RecommendationMovieParameter parameter) async {
    final response= await Dio().get(AppConstants.getRecommendationMoviePath(parameter.id));
    if(response.statusCode == 200){
      return List<RecommendationMovieModel>.from((response.data["results"]as List).map((e) => RecommendationMovieModel.fromJson(e)));
    }
    else{
      throw(
          ServerException(errorModel: ErrorModel.fromJson(response.data))
      );
    }
  }

}