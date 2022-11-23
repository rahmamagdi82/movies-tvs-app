import 'package:equatable/equatable.dart';

class Episode extends Equatable{
  final int id;
  final String? stillPath;
  final String airDate;
  final int episodeNumber;
  final String name;
  final String overView;


  const Episode({
    required this.id,
    required this.stillPath,
    required this.airDate,
    required this.episodeNumber,
    required this.name,
    required this.overView
  });

  @override
  List<Object?> get props => [
    id,
    stillPath,
    airDate,
    episodeNumber,
    name,
    overView
  ];
}