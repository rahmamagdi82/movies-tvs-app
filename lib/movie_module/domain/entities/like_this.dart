import 'package:equatable/equatable.dart';

class LikeThis extends Equatable{
  final String? backdropPath;
  final int id;

  const LikeThis({
    required this.backdropPath,
    required this.id,
  });

  @override
  List<Object?> get props => [
    backdropPath,
    id,
  ];

}