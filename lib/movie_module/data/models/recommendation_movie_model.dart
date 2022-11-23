import 'package:movies/movie_module/domain/entities/like_this.dart';

class RecommendationMovieModel extends LikeThis{
  const RecommendationMovieModel({
    required super.backdropPath,
    required super.id,
  });

  factory RecommendationMovieModel.fromJson(Map<String,dynamic> json){
    return RecommendationMovieModel(
        backdropPath: json['backdrop_path'],
        id: json['id'],
    );
  }
}