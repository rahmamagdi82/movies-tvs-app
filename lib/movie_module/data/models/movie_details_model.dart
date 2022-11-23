import 'package:movies/movie_module/data/models/genres_model.dart';
import 'package:movies/movie_module/domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetails{
  const MovieDetailsModel({
    required super.backdropPath,
    required super.genres,
    required super.id,
    required super.title,
    required super.overview,
    required super.voteAverage,
    required super.releaseDate,
    required super.runTime
  });

  factory MovieDetailsModel.fromJson(Map<String,dynamic> json){
    return MovieDetailsModel(
        backdropPath: json["backdrop_path"],
        genres: List<GenresModel>.from(json["genres"].map((e) => GenresModel.fromJson(e))),
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        voteAverage: json['vote_average'].toDouble(),
        releaseDate: json['release_date'],
      runTime: json['runtime']
    );
  }
}