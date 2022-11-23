import 'package:bloc/bloc.dart';
import 'package:movies/app/base_usecase.dart';
import 'package:movies/app/enums.dart';
import 'package:movies/movie_module/domain/usecase/playing_movies_usecase.dart';
import 'package:movies/movie_module/domain/usecase/popular_movies_usecase.dart';
import 'package:movies/movie_module/domain/usecase/top_rating_movies_usecase.dart';
import 'package:movies/movie_module/pressentation/controller/movies_bloc/movies_event.dart';
import 'package:movies/movie_module/pressentation/controller/movies_bloc/movies_state.dart';

class MovieBloc extends Bloc<MoviesEvent,MoviesState>{
  final GetPlayingMoviesUseCase getPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatingMoviesUseCase getTopRatingMoviesUseCase;

  MovieBloc(this.getPlayingMoviesUseCase,this.getPopularMoviesUseCase,this.getTopRatingMoviesUseCase):super(const MoviesState()){
    on<GetPlayingNowMoviesEvent>((event,emit) async {
      final result=await getPlayingMoviesUseCase(const NoParameter());
      result.fold(
              (l) => emit(state.copyWith(nowPlayingRequestState: RequestState.error,nowPlayingMessage: l.message)),
              (r) => emit(state.copyWith(nowPlayingMoviesList: r,nowPlayingRequestState: RequestState.success))
      );
      });

    on<GetPopularMoviesEvent>((event,emit) async {
      final result=await getPopularMoviesUseCase(const NoParameter());
      result.fold(
              (l) => emit(state.copyWith(popularRequestState: RequestState.error,popularMessage: l.message)),
              (r) => emit(state.copyWith(popularMoviesList: r,popularRequestState: RequestState.success))
      );
    });

    on<GetTopRatingNowMoviesEvent>((event,emit) async {
      final result=await getTopRatingMoviesUseCase(const NoParameter());
      result.fold(
              (l) => emit(state.copyWith(topRatingRequestState: RequestState.error,topRatingMessage: l.message)),
              (r) => emit(state.copyWith(topRatingMoviesList: r,topRatingRequestState: RequestState.success))
      );
    });
  }
}