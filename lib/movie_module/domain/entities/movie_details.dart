import 'package:equatable/equatable.dart';

import 'genres.dart';

class MovieDetails extends Equatable{
  final String backdropPath;
  final List<Genres> genres;
  final int id;
  final String title;
  final String overview;
  final double voteAverage;
  final String releaseDate;
  final int runTime;

  const MovieDetails({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
    required this.runTime
  });

  @override
  List<Object?> get props => [
    backdropPath,
    genres,
    id,
    title,
    overview,
    voteAverage,
    releaseDate,
    runTime
  ];
}