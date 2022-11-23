
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/tv_module/domain/entities/recommendation_tv.dart';
import 'package:movies/tv_module/domain/entities/season.dart';
import 'package:movies/tv_module/domain/entities/tv_details.dart';
import 'package:movies/tv_module/domain/usecase/tv_details_usecase.dart';

import '../../../../app/enums.dart';
import '../../../domain/usecase/recommendation_tv_usecase.dart';

part 'details_tv_event.dart';
part 'details_tv_state.dart';

class DetailsTvBloc extends Bloc<DetailsTvEvent, DetailsTvState> {
  final GetTvDetailsUseCase getTvDetailsUseCase;

  final GetRecommendationTvsUseCase getRecommendationTvUseCase;
  DetailsTvBloc(this.getTvDetailsUseCase,this.getRecommendationTvUseCase) : super(const DetailsTvState()) {
    on<GetTvDetailsEvent>((event, emit) async {
      final result = await getTvDetailsUseCase.call(TvDetailsParameter(id: event.id));
      result.fold(
            (l) => emit(state.copyWith(tvDetailsState: RequestState.error,tvDetailsMessage: l.message)),
            (r) => emit(state.copyWith(tvDetails: r,tvDetailsState: RequestState.success)),
      );
    });

    on<GetRecommendationTvEvent>((event, emit) async {
      final result = await getRecommendationTvUseCase.call(RecommendationTvsParameter(id: event.id,));
      result.fold(
            (l) => emit(state.copyWith(recommendationTvRequest: RequestState.error,recommendationTvMessage: l.message)),
            (r) => emit(state.copyWith(recommendationTvList: r,recommendationTvRequest: RequestState.success)),
      );
    });

    on<GetShowEvent>((event, emit) async {
       emit(state.copyWith(showRecommendationWidget: event.showRecommendationWidget,showDetailsWidget: event.showDetails));
      });
  }
}
