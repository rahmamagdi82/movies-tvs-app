import '../../domain/entities/tv.dart';

class TvModel extends Tv{
  const TvModel({
    required super.backdropPath,
    required super.name,
    required super.id,
    required super.firstAirDate,
    required super.voteAverage,
    required super.overView,
  });
  
  factory TvModel.fromJson(Map<String,dynamic> json){
    return TvModel(
        backdropPath: json['backdrop_path'],
        name: json['name'],
        id: json['id'], 
      firstAirDate: json['first_air_date'],
      voteAverage: json['vote_average'].toDouble(),
      overView: json['overview'],
    );
  }
}