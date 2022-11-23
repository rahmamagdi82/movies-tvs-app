import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../app/base_usecase.dart';
import '../../../app/error/failure.dart';
import '../entities/season.dart';
import '../repository/repository.dart';

class GetSeasonTvUseCase extends BaseUseCase<SeasonTvParameter>{
  final BaseTvRepository baseTvRepository;
  GetSeasonTvUseCase(this.baseTvRepository);

  @override
  Future<Either<Failure, Season>> call(parameter) async {
    return await baseTvRepository.getSeasonTv(parameter);
  }
}

class SeasonTvParameter extends Equatable{
  final int id;
  final int seasonNumber;
  const SeasonTvParameter({required this.id,required this.seasonNumber});
  @override
  List<Object?> get props => [
    id,
    seasonNumber
  ];
}