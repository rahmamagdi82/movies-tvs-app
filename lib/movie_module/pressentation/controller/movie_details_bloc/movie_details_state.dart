part of 'movie_details_bloc.dart';

class MovieDetailsState extends Equatable {
  final MovieDetails? movieDetails;
  final RequestState movieDetailsState;
  final String movieDetailsMessage;

  final List<LikeThis> recommendationMoviesList;
  final RequestState recommendationMoviesRequestState;
  final String recommendationMoviesMessage;

   const MovieDetailsState({
     this.movieDetails,
     this.movieDetailsState = RequestState.loading,
     this.movieDetailsMessage = '',
     this.recommendationMoviesList = const [],
     this.recommendationMoviesRequestState = RequestState.loading,
     this.recommendationMoviesMessage = '',
   });

   MovieDetailsState copyWith({
      MovieDetails? movieDetails,
      RequestState? movieDetailsState,
      String? movieDetailsMessage,
      List<LikeThis>? recommendationMoviesList,
      RequestState? recommendationMoviesRequestState,
      String? recommendationMoviesMessage,
}){
     return MovieDetailsState(
         movieDetails : movieDetails ?? this.movieDetails,
         movieDetailsState : movieDetailsState ?? this.movieDetailsState,
         movieDetailsMessage : movieDetailsMessage ?? this.movieDetailsMessage,
         recommendationMoviesList : recommendationMoviesList ?? this.recommendationMoviesList,
         recommendationMoviesRequestState : recommendationMoviesRequestState ?? this.recommendationMoviesRequestState,
         recommendationMoviesMessage : recommendationMoviesMessage ?? this.recommendationMoviesMessage
     );
   }

  @override
  List<Object?> get props => [
    movieDetails,
    movieDetailsState,
    movieDetailsMessage,
    recommendationMoviesList,
    recommendationMoviesRequestState,
    recommendationMoviesMessage
  ];
}

