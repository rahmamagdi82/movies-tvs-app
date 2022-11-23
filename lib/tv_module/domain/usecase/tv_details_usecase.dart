import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/app/base_usecase.dart';
import 'package:movies/app/error/failure.dart';
import 'package:movies/tv_module/domain/entities/tv_details.dart';
import 'package:movies/tv_module/domain/repository/repository.dart';

class GetTvDetailsUseCase extends BaseUseCase<TvDetailsParameter>{
  final BaseTvRepository baseTvRepository;
  GetTvDetailsUseCase(this.baseTvRepository);

  @override
  Future<Either<Failure, TvDetails>> call(parameter) async {
    return await baseTvRepository.getTvDetails(parameter);
  }
}

class TvDetailsParameter extends Equatable{
  final int id;
  const TvDetailsParameter({required this.id});
  @override
  List<Object?> get props => [
    id,
  ];
}