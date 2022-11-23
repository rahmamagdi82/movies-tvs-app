import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable{
  final String statusMessage;
  final int statusCode;
  final bool success;


  const ErrorModel({
    required this.statusMessage,
    required this.statusCode,
    required this.success});

  factory ErrorModel.fromJson(Map<String,dynamic> json){
    return ErrorModel(
        statusMessage:  json["status_message"],
        statusCode: json["status_code"],
        success: json["success"]
    );
  }

  @override
  List<Object?> get props => [
    statusMessage,
    statusCode,
    success
  ];
}