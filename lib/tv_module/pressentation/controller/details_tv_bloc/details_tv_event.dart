part of 'details_tv_bloc.dart';

abstract class DetailsTvEvent extends Equatable{
  const DetailsTvEvent();
}

class GetTvDetailsEvent extends DetailsTvEvent{
  final int id;

  const GetTvDetailsEvent(this.id);
  @override
  List<Object?> get props => [
    id,
  ];
}

class GetRecommendationTvEvent extends DetailsTvEvent{
  final int id;
  const GetRecommendationTvEvent(this.id);
  @override
  List<Object?> get props => [
    id,
  ];
}

class GetShowEvent extends DetailsTvEvent{
  final bool showDetails;
  final bool showRecommendationWidget;
  const GetShowEvent(this.showDetails,this.showRecommendationWidget);
  @override
  List<Object?> get props => [
    showDetails,
    showRecommendationWidget
  ];

}