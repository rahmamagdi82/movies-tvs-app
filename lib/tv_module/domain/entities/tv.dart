import 'package:equatable/equatable.dart';

class Tv extends Equatable{
  final String? backdropPath;
  final String name;
  final int id;
  final String firstAirDate;
  final double voteAverage;
  final String overView;


  const Tv({
    required this.backdropPath,
    required this.name,
    required this.id,
    required this.firstAirDate,
    required this.voteAverage,
    required this.overView,

  });

  @override
  List<Object?> get props => [
    backdropPath,
    name,
    id,
    firstAirDate,
    voteAverage,
    overView
  ];
}