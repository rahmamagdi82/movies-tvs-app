part of 'details_tv_bloc.dart';

class DetailsTvState extends Equatable{
  final TvDetails? tvDetails;
  final RequestState tvDetailsState;
  final String tvDetailsMessage;
  final bool showDetailsWidget;

  final List<RecommendationTv> recommendationTvList;
  final RequestState recommendationTvRequest;
  final String recommendationTvMessage;
  final bool showRecommendationWidget;

  const DetailsTvState({
    this.tvDetails,
    this.tvDetailsState= RequestState.loading,
    this.tvDetailsMessage= '',
    this.recommendationTvList=const[],
    this.recommendationTvRequest= RequestState.loading,
    this.recommendationTvMessage= '',
    this.showDetailsWidget=true,
    this.showRecommendationWidget=false
  });

  DetailsTvState copyWith({
    TvDetails? tvDetails,
    RequestState? tvDetailsState,
    String? tvDetailsMessage,
    List<RecommendationTv>? recommendationTvList,
    RequestState? recommendationTvRequest,
    String? recommendationTvMessage,
    Season? season,
    RequestState? seasonTvRequest,
    String? seasonTvMessage,
    bool? showDetailsWidget,
    bool? showRecommendationWidget
  }){
    return DetailsTvState(
      tvDetails : tvDetails ?? this.tvDetails,
      tvDetailsState : tvDetailsState ?? this.tvDetailsState,
      tvDetailsMessage : tvDetailsMessage ?? this.tvDetailsMessage,
      recommendationTvList : recommendationTvList ?? this.recommendationTvList,
      recommendationTvRequest : recommendationTvRequest ?? this.recommendationTvRequest,
      recommendationTvMessage : recommendationTvMessage ?? this.recommendationTvMessage,
      showDetailsWidget:showDetailsWidget??this.showDetailsWidget,
      showRecommendationWidget:showRecommendationWidget??this.showRecommendationWidget
    );
  }

  @override
  List<Object?> get props => [
    tvDetails,
    tvDetailsState,
    tvDetailsMessage,
    recommendationTvList,
    recommendationTvRequest,
    recommendationTvMessage,
    showDetailsWidget,
    showRecommendationWidget
  ];
}