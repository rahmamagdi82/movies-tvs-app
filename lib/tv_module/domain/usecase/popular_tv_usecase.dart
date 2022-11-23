import 'package:dartz/dartz.dart';
import 'package:movies/app/base_usecase.dart';
import 'package:movies/app/error/failure.dart';

import '../repository/repository.dart';

class GetPopularTvUseCase extends BaseUseCase<NoParameter>{
  final BaseTvRepository baseTvRepository;
  GetPopularTvUseCase(this.baseTvRepository);
  @override
  Future<Either<Failure, dynamic>> call(parameter) async {
    return await baseTvRepository.getPopularTv();
  }

}