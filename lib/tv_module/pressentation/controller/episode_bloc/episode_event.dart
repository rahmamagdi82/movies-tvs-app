part of 'episode_bloc.dart';

abstract class EpisodeEvent extends Equatable{
  const EpisodeEvent();
}

class GetSeasonTvEvent extends EpisodeEvent{
  final int id;
  final int seasonNumber;
  const GetSeasonTvEvent(this.id,this.seasonNumber);
  @override
  List<Object?> get props => [
    id,
    seasonNumber
  ];
}