import 'package:equatable/equatable.dart';
import 'package:movies/app/enums.dart';

import '../../../domain/entities/movie.dart';

class MoviesState extends Equatable{
  final List<Movie> nowPlayingMoviesList;
  final RequestState nowPlayingRequestState;
  final String nowPlayingMessage;

  final List<Movie> popularMoviesList;
  final RequestState popularRequestState;
  final String popularMessage;

  final List<Movie> topRatingMoviesList;
  final RequestState topRatingRequestState;
  final String topRatingMessage;

  const MoviesState({
    this.nowPlayingMoviesList=const[],
    this.nowPlayingRequestState=RequestState.loading,
    this.nowPlayingMessage='',
    this.popularMoviesList=const[],
    this.popularRequestState=RequestState.loading,
    this.popularMessage='',
    this.topRatingMoviesList=const[],
    this.topRatingRequestState=RequestState.loading,
    this.topRatingMessage='',
  });

  MoviesState copyWith({
     List<Movie>? nowPlayingMoviesList,
     RequestState? nowPlayingRequestState,
     String? nowPlayingMessage,
     List<Movie>? popularMoviesList,
     RequestState? popularRequestState,
     String? popularMessage,
     List<Movie>? topRatingMoviesList,
     RequestState? topRatingRequestState,
     String? topRatingMessage,
}){
    return MoviesState(
      nowPlayingMoviesList: nowPlayingMoviesList ?? this.nowPlayingMoviesList,
      nowPlayingRequestState: nowPlayingRequestState ?? this.nowPlayingRequestState,
      nowPlayingMessage: nowPlayingMessage ?? this.nowPlayingMessage,
      popularMoviesList: popularMoviesList ?? this.popularMoviesList,
      popularRequestState: popularRequestState ?? this.popularRequestState,
      popularMessage: popularMessage ?? this.popularMessage,
      topRatingMoviesList: topRatingMoviesList ?? this.nowPlayingMoviesList,
      topRatingRequestState: topRatingRequestState ?? this.topRatingRequestState,
      topRatingMessage: topRatingMessage ?? this.topRatingMessage

    );

  }

  @override
  List<Object?> get props => [
    nowPlayingMoviesList,
    nowPlayingRequestState,
    nowPlayingMessage,
    popularMoviesList,
    popularRequestState,
    popularMessage,
    topRatingMoviesList,
    topRatingRequestState,
    topRatingMessage,
  ];
}