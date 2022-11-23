import 'package:movies/movie_module/domain/entities/movie.dart';

class MovieModel extends Movie{
  const MovieModel({
    required super.backdropPath,
    required super.genreIds,
    required super.id,
    required super.title,
    required super.overview,
    required super.voteAverage,
    required super.releaseDate
  });

  factory MovieModel.fromJson(Map<String,dynamic> json){
    return MovieModel(
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((e) => e)),
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        voteAverage: json['vote_average'].toDouble(),
        releaseDate: json['release_date']
    );
  }
}