import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/movie_module/domain/entities/movie_details.dart';

import '../../../app/base_usecase.dart';
import '../../../app/error/failure.dart';
import '../repository/movie_repository.dart';

class GetMovieDetailsUseCase extends BaseUseCase<MovieDetailsParameter>{
  final BaseMoviesRepository baseMoviesRepository;
  GetMovieDetailsUseCase(this.baseMoviesRepository);
  @override
  Future<Either<Failure,MovieDetails>> call(MovieDetailsParameter parameter) async{
    return await baseMoviesRepository.getMovieDetails(parameter);
  }
}

class MovieDetailsParameter extends Equatable{
  final int id;
  const MovieDetailsParameter({required this.id});
  @override
  List<Object?> get props => [
    id,
  ];
}