import 'package:dartz/dartz.dart';
import 'package:movies/app/error/exception.dart';
import 'package:movies/app/error/failure.dart';
import 'package:movies/movie_module/data/datasource/remote_datasource.dart';
import 'package:movies/movie_module/domain/entities/like_this.dart';
import 'package:movies/movie_module/domain/entities/movie.dart';
import 'package:movies/movie_module/domain/entities/movie_details.dart';
import 'package:movies/movie_module/domain/repository/movie_repository.dart';

import '../../domain/usecase/details_movie_usecase.dart';
import '../../domain/usecase/recommendations_usecase.dart';

class RepositoryImp extends BaseMoviesRepository{
  final BaseRemoteDataSource baseRemoteDataSource;
  RepositoryImp(this.baseRemoteDataSource);

  @override
  Future<Either<Failure,List<Movie>>> getPlayingMovies() async{
    final result= await baseRemoteDataSource.getPlayingMovies();
    try{
      return Right(result);
    } on ServerException catch(failure){
      return Left(ServireFailure(failure.errorModel.statusMessage));
    }

  }

  @override
  Future<Either<Failure,List<Movie>>> getPopularMovies() async {
    final result= await baseRemoteDataSource.getPopularMovies();
    try{
      return Right(result);
    } on ServerException catch(failure){
      return Left(ServireFailure(failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure,List<Movie>>> getTopRatedMovies() async {
    final result= await baseRemoteDataSource.getTopRatingMovies();
    try{
      return Right(result);
    } on ServerException catch(failure){
      return Left(ServireFailure(failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(MovieDetailsParameter parameter) async {
    final result= await baseRemoteDataSource.getMovieDetails(parameter);
    try{
      return Right(result);
    } on ServerException catch(failure){
      return Left(ServireFailure(failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<LikeThis>>> getRecommendationMovies(RecommendationMovieParameter parameter) async {
    final result= await baseRemoteDataSource.getRecommendationMovies(parameter);
    try{
      return Right(result);
    } on ServerException catch(failure){
      return Left(ServireFailure(failure.errorModel.statusMessage));
    }
  }
}