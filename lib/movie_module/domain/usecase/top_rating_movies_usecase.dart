import 'package:dartz/dartz.dart';
import 'package:movies/app/base_usecase.dart';
import 'package:movies/movie_module/domain/repository/movie_repository.dart';

import '../../../app/error/failure.dart';
import '../entities/movie.dart';

class GetTopRatingMoviesUseCase extends BaseUseCase<NoParameter>{
  final BaseMoviesRepository baseMoviesRepository;
  GetTopRatingMoviesUseCase(this.baseMoviesRepository);
  @override
  Future<Either<Failure,List<Movie>>> call(NoParameter parameter) async{
    return await baseMoviesRepository.getTopRatedMovies();
  }
}