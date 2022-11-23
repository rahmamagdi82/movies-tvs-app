import 'package:dartz/dartz.dart';
import 'package:movies/app/base_usecase.dart';
import 'package:movies/app/error/failure.dart';

import '../repository/repository.dart';

class GetTopRattedTvUseCase extends BaseUseCase<NoParameter>{
  final BaseTvRepository baseTvRepository;
  GetTopRattedTvUseCase(this.baseTvRepository);
  @override
  Future<Either<Failure, dynamic>> call(NoParameter parameter) async {
    return await baseTvRepository.getTopRattedTv();
  }
}