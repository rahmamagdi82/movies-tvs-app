import 'package:movies/tv_module/data/models/genres_model.dart';
import 'package:movies/tv_module/domain/entities/tv_details.dart';

class TvDetailsModel extends TvDetails{

  const TvDetailsModel({
    required super.backdropPath,
    required super.name,
    required super.id,
    required super.firstAirDate,
    required super.voteAverage,
    required super.overView,
    required super.numberOfSeasons,
    required super.episodeRunTime,
    required super.genres
  });

  factory TvDetailsModel.fromJson(Map<String,dynamic> json){
    return TvDetailsModel(
        backdropPath: json["backdrop_path"],
        id: json['id'],
        name: json['name'],
        overView: json['overview'],
        voteAverage: json['vote_average'].toDouble(),
        firstAirDate: json['first_air_date'],
      episodeRunTime: json['episode_run_time'],
      numberOfSeasons: json['number_of_seasons'],
      genres: List<GenresModel>.from(json["genres"].map((e) => GenresModel.fromJson(e))),
    );
  }
}