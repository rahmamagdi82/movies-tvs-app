import 'package:dartz/dartz.dart';
import 'package:movies/tv_module/domain/entities/recommendation_tv.dart';
import 'package:movies/tv_module/domain/entities/season.dart';
import 'package:movies/tv_module/domain/entities/tv_details.dart';
import 'package:movies/tv_module/domain/usecase/recommendation_tv_usecase.dart';

import '../../../app/error/failure.dart';
import '../entities/tv.dart';
import '../usecase/tv_details_usecase.dart';
import '../usecase/tv_season_usecase.dart';

abstract class BaseTvRepository{
  Future<Either<Failure, List<Tv>>> getOnAir();
  Future<Either<Failure, List<Tv>>> getPopularTv();
  Future<Either<Failure, List<Tv>>> getTopRattedTv();
  Future<Either<Failure, TvDetails>> getTvDetails(TvDetailsParameter parameter);
  Future<Either<Failure, List<RecommendationTv>>> getRecommendationTv(RecommendationTvsParameter parameter);
  Future<Either<Failure, Season>> getSeasonTv(SeasonTvParameter parameter);



}