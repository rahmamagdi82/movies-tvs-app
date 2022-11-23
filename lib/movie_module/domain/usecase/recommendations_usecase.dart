import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/movie_module/domain/entities/like_this.dart';

import '../../../app/base_usecase.dart';
import '../../../app/error/failure.dart';
import '../repository/movie_repository.dart';

class GetRecommendationMoviesUseCase extends BaseUseCase<RecommendationMovieParameter>{
  final BaseMoviesRepository baseMoviesRepository;
  GetRecommendationMoviesUseCase(this.baseMoviesRepository);
  @override
  Future<Either<Failure,List<LikeThis>>> call(RecommendationMovieParameter parameter) async{
    return await baseMoviesRepository.getRecommendationMovies(parameter);
  }
}

class RecommendationMovieParameter extends Equatable{
  final int id;
  const RecommendationMovieParameter({required this.id});
  @override
  List<Object?> get props => [
    id,
  ];
}