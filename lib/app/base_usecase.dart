import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/app/error/failure.dart';

abstract class BaseUseCase<Parameters>{
  Future<Either<Failure,dynamic>> call(Parameters parameter);
}

class NoParameter extends Equatable{
  const NoParameter();

  @override
  List<Object?> get props => [];

}