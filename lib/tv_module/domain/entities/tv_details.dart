import 'package:equatable/equatable.dart';
import 'package:movies/tv_module/domain/entities/genres.dart';

class TvDetails extends Equatable{
  final String? backdropPath;
  final String name;
  final int id;
  final String firstAirDate;
  final double voteAverage;
  final String overView;
  final int numberOfSeasons;
  final List episodeRunTime;
  final List<Genres> genres;


  const TvDetails({
    required this.backdropPath,
    required this.name,
    required this.id,
    required this.firstAirDate,
    required this.voteAverage,
    required this.overView,
    required this.numberOfSeasons,
    required this.episodeRunTime,
    required this.genres
  });

  @override
  List<Object?> get props => [
    backdropPath,
    name,
    id,
    firstAirDate,
    voteAverage,
    overView,
    numberOfSeasons,
    episodeRunTime,
    genres
  ];
}