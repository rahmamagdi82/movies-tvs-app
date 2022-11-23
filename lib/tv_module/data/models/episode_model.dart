import '../../domain/entities/episode.dart';

class EpisodeModel extends Episode{
  const EpisodeModel({
    required super.id,
    required super.stillPath,
    required super.airDate,
    required super.episodeNumber,
    required super.name,
    required super.overView
  });

  factory EpisodeModel.fromJson(Map<String,dynamic> json){
    return EpisodeModel(
        id: json['id'],
        stillPath: json['still_path'],
        airDate: json['air_date'],
        episodeNumber: json['episode_number'],
        name: json['name'],
        overView: json['overview']
    );
  }
}