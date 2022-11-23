part of 'tv_bloc.dart';

class TvState extends Equatable{
  final List<Tv> onAirTvList;
  final RequestState onAirTvRequestState;
  final String onAirTvMessage;

  final List<Tv> popularTvList;
  final RequestState popularTvRequestState;
  final String popularTvMessage;

  final List<Tv> topRatingTvList;
  final RequestState topRatingTvRequestState;
  final String topRatingTvMessage;

  const TvState({
    this.onAirTvList=const [],
    this.onAirTvRequestState=RequestState.loading,
    this.onAirTvMessage='',
    this.popularTvList=const [],
    this.popularTvRequestState=RequestState.loading,
    this.popularTvMessage='',
    this.topRatingTvList=const [],
    this.topRatingTvRequestState=RequestState.loading,
    this.topRatingTvMessage=''
  });


  TvState copyWith({
    List<Tv>? onAirTvList,
    RequestState? onAirTvRequestState,
    String? onAirTvMessage,
    List<Tv>? popularTvList,
    RequestState? popularTvRequestState,
    String? popularTvMessage,
    List<Tv>? topRatingTvList,
    RequestState? topRatingTvRequestState,
    String? topRatingTvMessage
  }){
    return TvState(
        onAirTvList : onAirTvList ?? this.onAirTvList,
        onAirTvRequestState : onAirTvRequestState ?? this.onAirTvRequestState,
        onAirTvMessage:onAirTvMessage??this.onAirTvMessage,
        popularTvList:popularTvList??this.popularTvList,
        popularTvRequestState:popularTvRequestState??this.popularTvRequestState,
        popularTvMessage:popularTvMessage??this.popularTvMessage,
        topRatingTvList:topRatingTvList??this.topRatingTvList,
        topRatingTvRequestState:topRatingTvRequestState??this.topRatingTvRequestState,
        topRatingTvMessage:topRatingTvMessage??this.topRatingTvMessage
    );
  }

  @override
  List<Object?> get props => [
    onAirTvList,
    onAirTvRequestState,
    onAirTvMessage,
    popularTvList,
    popularTvRequestState,
    popularTvMessage,
    topRatingTvList,
    topRatingTvRequestState,
    topRatingTvMessage
  ];
}