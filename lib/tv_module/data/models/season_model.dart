import 'package:movies/tv_module/data/models/episode_model.dart';

import '../../domain/entities/season.dart';

class SeasonModel extends Season{
  const SeasonModel({
    required super.id,
    required super.name,
    required super.episodes
  });

  factory SeasonModel.fromJson(Map<String,dynamic> json){
    return SeasonModel(
        id: json['id'],
        name: json['name'],
        episodes: List<EpisodeModel>.from(json["episodes"].map((e) => EpisodeModel.fromJson(e)))
    );
  }
}