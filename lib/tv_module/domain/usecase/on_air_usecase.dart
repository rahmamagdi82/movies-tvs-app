import 'package:dartz/dartz.dart';
import 'package:movies/app/base_usecase.dart';
import 'package:movies/app/error/failure.dart';
import 'package:movies/tv_module/domain/repository/repository.dart';

import '../entities/tv.dart';

class GetOnAirUseCase extends BaseUseCase<NoParameter>{
  final BaseTvRepository baseTvRepository;
  GetOnAirUseCase(this.baseTvRepository);

  @override
  Future<Either<Failure, List<Tv>>> call(parameter) async {
    return await baseTvRepository.getOnAir();
  }
}