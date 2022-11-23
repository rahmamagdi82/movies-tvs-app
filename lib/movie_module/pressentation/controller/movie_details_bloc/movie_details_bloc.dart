
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/movie_module/domain/entities/like_this.dart';
import 'package:movies/movie_module/domain/entities/movie_details.dart';

import '../../../../app/enums.dart';
import '../../../domain/usecase/details_movie_usecase.dart';
import '../../../domain/usecase/recommendations_usecase.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {

  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetRecommendationMoviesUseCase getRecommendationMoviesUseCase;
  MovieDetailsBloc(this.getMovieDetailsUseCase,this.getRecommendationMoviesUseCase) : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>((event, emit) async {
      final result = await getMovieDetailsUseCase.call(MovieDetailsParameter(id: event.id));
      result.fold(
              (l) => emit(state.copyWith(movieDetailsState: RequestState.error,movieDetailsMessage: l.message)),
              (r) => emit(state.copyWith(movieDetails: r,movieDetailsState: RequestState.success)),
      );
    });

    on<GetRecommendationMoviesEvent>((event, emit) async {
      final result = await getRecommendationMoviesUseCase.call(RecommendationMovieParameter(id: event.id));
      result.fold(
            (l) => emit(state.copyWith(recommendationMoviesRequestState: RequestState.error,recommendationMoviesMessage: l.message)),
            (r) => emit(state.copyWith(recommendationMoviesList: r,recommendationMoviesRequestState: RequestState.success)),
      );
    });
  }
}
