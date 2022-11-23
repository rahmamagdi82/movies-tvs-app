part of 'episode_bloc.dart';

class EpisodeState extends Equatable{
  final Season? season;
  final RequestState seasonTvRequest;
  final String seasonTvMessage;


  const EpisodeState({
    this.season,
    this.seasonTvRequest= RequestState.loading,
    this.seasonTvMessage= '',
  });

  EpisodeState copyWith({
    Season? season,
    RequestState? seasonTvRequest,
    String? seasonTvMessage,
  }){
    return EpisodeState(
      season : season ?? this.season,
      seasonTvRequest : seasonTvRequest ?? this.seasonTvRequest,
      seasonTvMessage : seasonTvMessage ?? this.seasonTvMessage,
    );
  }

  @override
  List<Object?> get props => [
    season,
    seasonTvRequest,
    seasonTvMessage,
  ];

}

