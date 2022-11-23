import 'package:dartz/dartz.dart';

import 'package:movies/app/error/failure.dart';
import 'package:movies/tv_module/domain/entities/recommendation_tv.dart';
import 'package:movies/tv_module/domain/entities/season.dart';

import 'package:movies/tv_module/domain/entities/tv.dart';
import 'package:movies/tv_module/domain/entities/tv_details.dart';
import 'package:movies/tv_module/domain/usecase/recommendation_tv_usecase.dart';
import 'package:movies/tv_module/domain/usecase/tv_details_usecase.dart';
import 'package:movies/tv_module/domain/usecase/tv_season_usecase.dart';

import '../../../app/error/exception.dart';
import '../../domain/repository/repository.dart';
import '../datasource/remote_datasource.dart';

class TvRepositoryImp extends BaseTvRepository{
  final BaseTvRemoteDataSource baseTvRemoteDataSource;
  TvRepositoryImp(this.baseTvRemoteDataSource);
  @override
  Future<Either<Failure, List<Tv>>> getOnAir() async {
    final result =await baseTvRemoteDataSource.getTvOnAir();
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServireFailure(failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTv() async {
    final result=await baseTvRemoteDataSource.getPopularTv();
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServireFailure(failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRattedTv() async {
    final result=await baseTvRemoteDataSource.getTopRattedTv();
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServireFailure(failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, TvDetails>> getTvDetails(TvDetailsParameter parameter) async {
    final result=await baseTvRemoteDataSource.getTvDetails(parameter);
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServireFailure(failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<RecommendationTv>>> getRecommendationTv(RecommendationTvsParameter parameter) async {
    final result = await baseTvRemoteDataSource.getRecommendationTv(parameter);
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServireFailure(failure.errorModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Season>> getSeasonTv(SeasonTvParameter parameter) async {
    final result = await baseTvRemoteDataSource.getSeasonTv(parameter);
    try{
      return Right(result);
    }on ServerException catch(failure)
    {
      return Left(ServireFailure(failure.errorModel.statusMessage));
    }
  }
}