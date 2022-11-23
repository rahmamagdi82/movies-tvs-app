import 'package:dio/dio.dart';
import 'package:movies/app/resource/constants.dart';
import 'package:movies/tv_module/data/models/recommendation_tv_nmodel.dart';
import 'package:movies/tv_module/data/models/tv_details_model.dart';
import 'package:movies/tv_module/domain/usecase/tv_details_usecase.dart';
import 'package:movies/tv_module/domain/usecase/tv_season_usecase.dart';

import '../../../app/Network/error_model.dart';
import '../../../app/error/exception.dart';
import '../../domain/usecase/recommendation_tv_usecase.dart';
import '../models/season_model.dart';
import '../models/tv_model.dart';

abstract class BaseTvRemoteDataSource{
  Future<List<TvModel>> getTvOnAir();
  Future<List<TvModel>> getPopularTv();
  Future<List<TvModel>> getTopRattedTv();
  Future<TvDetailsModel> getTvDetails(TvDetailsParameter parameter);
  Future<List<RecommendationTvModel>> getRecommendationTv(RecommendationTvsParameter parameter);
  Future<SeasonModel> getSeasonTv(SeasonTvParameter parameter);
}

class TvRemoteDataSource implements BaseTvRemoteDataSource{
  @override
  Future<List<TvModel>> getTvOnAir() async {
    final response=await Dio().get(AppConstants.getOnAirTvPath());
    if(response.statusCode == 200) {
      return List<TvModel>.from((response.data["results"]as List).map((e) => TvModel.fromJson(e)));
    }else
    {
      throw(
          ServerException(errorModel: ErrorModel.fromJson(response.data))
      );
    }

  }

  @override
  Future<List<TvModel>> getPopularTv() async {
    final response = await Dio().get(AppConstants.getPopularTvPath());
    if(response.statusCode == 200){
      return List<TvModel>.from((response.data["results"]as List).map((e) => TvModel.fromJson(e)));
    }else
      {
        throw(
            ServerException(errorModel: ErrorModel.fromJson(response.data))
        );
      }
  }

  @override
  Future<List<TvModel>> getTopRattedTv() async {
    final response = await Dio().get(AppConstants.getTopRatingTvPath());
    if(response.statusCode == 200){
      return List<TvModel>.from((response.data["results"]as List).map((e) => TvModel.fromJson(e)));
    }else
      {
        throw(
            ServerException(errorModel: ErrorModel.fromJson(response.data))
        );
      }
  }

  @override
  Future<TvDetailsModel> getTvDetails(TvDetailsParameter parameter) async {
    final response= await Dio().get(AppConstants.getTvDetailsPath(parameter.id));
    if(response.statusCode == 200){
      return TvDetailsModel.fromJson(response.data);
    }else
      {
        throw(
            ServerException(errorModel: ErrorModel.fromJson(response.data))
        );
      }
  }

  @override
  Future<List<RecommendationTvModel>> getRecommendationTv(RecommendationTvsParameter parameter) async {
    final response=await Dio().get(AppConstants.getRecommendationTvPath(parameter.id));
    if(response.statusCode == 200){
      return List<RecommendationTvModel>.from((response.data['results']as List).map((e) => RecommendationTvModel.fromJson(e)));
    }else
      {
        throw(
            ServerException(errorModel: ErrorModel.fromJson(response.data))
        );
      }
  }

  @override
  Future<SeasonModel> getSeasonTv(SeasonTvParameter parameter) async {
    final response = await Dio().get(AppConstants.getSeasonsTvPath(parameter.id, parameter.seasonNumber));
    if(response.statusCode == 200){
      return SeasonModel.fromJson(response.data);
    }else
      {
        throw(
            ServerException(errorModel: ErrorModel.fromJson(response.data))
        );
      }
  }
}