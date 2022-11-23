part of 'tv_bloc.dart';

abstract class TvEvent extends Equatable{
  const TvEvent();

  @override
  List<Object?> get props => [];
}

class GetOnAirTvEvent extends TvEvent{}
class GetPopularTvEvent extends TvEvent{}
class GetTopRattedTvEvent extends TvEvent{}
