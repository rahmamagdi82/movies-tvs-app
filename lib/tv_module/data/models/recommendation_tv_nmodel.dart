import 'package:movies/tv_module/domain/entities/recommendation_tv.dart';

class RecommendationTvModel extends RecommendationTv{
  const RecommendationTvModel({
    required super.backdropPath,
    required super.id,
  });

  factory RecommendationTvModel.fromJson(Map<String,dynamic> json){
    return RecommendationTvModel(
      backdropPath: json['backdrop_path'],
      id: json['id'],
    );
  }
}