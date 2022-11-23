import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/app/base_usecase.dart';
import 'package:movies/app/error/failure.dart';
import 'package:movies/tv_module/domain/entities/recommendation_tv.dart';
import 'package:movies/tv_module/domain/repository/repository.dart';

class GetRecommendationTvsUseCase extends BaseUseCase<RecommendationTvsParameter>{
  final BaseTvRepository baseTvRepository;
  GetRecommendationTvsUseCase(this.baseTvRepository);

  @override
  Future<Either<Failure, List<RecommendationTv>>> call(parameter) async {
    return await baseTvRepository.getRecommendationTv(parameter);
  }
}

class RecommendationTvsParameter extends Equatable{
  final int id;
  const RecommendationTvsParameter({required this.id});
  @override
  List<Object?> get props => [
    id,
  ];
}