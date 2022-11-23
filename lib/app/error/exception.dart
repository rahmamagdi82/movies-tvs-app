import 'package:movies/app/Network/error_model.dart';

class ServerException implements Exception{
  final ErrorModel errorModel;
  const ServerException({required this.errorModel});

}