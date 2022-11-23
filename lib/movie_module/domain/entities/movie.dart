import 'package:equatable/equatable.dart';

class Movie extends Equatable{
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String title;
  final String overview;
  final double voteAverage;
  final String releaseDate;

  const Movie({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
      });

  @override
  List<Object?> get props => [
    backdropPath,
    genreIds,
    id,
    title,
    overview,
    voteAverage,
    releaseDate,
  ];

}