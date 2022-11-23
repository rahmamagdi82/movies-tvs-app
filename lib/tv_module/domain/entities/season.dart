import 'package:equatable/equatable.dart';

import 'episode.dart';

class Season extends Equatable{
  final int id;
  final String name;
  final List<Episode> episodes;


  const Season({required this.id, required this.name, required this.episodes});

  @override
  List<Object?> get props => [
    id,
    name,
    episodes
  ];
}