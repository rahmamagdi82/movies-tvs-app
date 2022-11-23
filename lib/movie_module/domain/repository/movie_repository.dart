import 'package:dartz/dartz.dart';
import 'package:movies/movie_module/domain/entities/like_this.dart';
import 'package:movies/movie_module/domain/usecase/recommendations_usecase.dart';

import '../../../app/error/failure.dart';
import '../entities/movie.dart';
import '../entities/movie_details.dart';
import '../usecase/details_movie_usecase.dart';

abstract class BaseMoviesRepository{
  Future<Either<Failure,List<Movie>>> getPlayingMovies();
  Future<Either<Failure,List<Movie>>> getPopularMovies();
  Future<Either<Failure,List<Movie>>> getTopRatedMovies();
  Future<Either<Failure,MovieDetails>> getMovieDetails(MovieDetailsParameter parameter);
  Future<Either<Failure,List<LikeThis>>> getRecommendationMovies(RecommendationMovieParameter parameter);
}