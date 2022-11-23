
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/app/base_usecase.dart';

import '../../../../app/enums.dart';
import '../../../domain/entities/tv.dart';
import '../../../domain/usecase/on_air_usecase.dart';
import '../../../domain/usecase/popular_tv_usecase.dart';
import '../../../domain/usecase/top_ratted_tv_usecase.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  GetOnAirUseCase getOnAirTvUseCase;
  GetPopularTvUseCase getPopularTvUseCase;
  GetTopRattedTvUseCase getTopRattedTvUseCase;

  TvBloc(this.getOnAirTvUseCase,this.getPopularTvUseCase,this.getTopRattedTvUseCase) : super(const TvState()) {
    on<GetOnAirTvEvent>((event, emit) async {
      final result=await getOnAirTvUseCase(const NoParameter());
      result.fold(
              (l) => emit(state.copyWith(onAirTvRequestState: RequestState.error,onAirTvMessage: l.message)),
              (r) => emit(state.copyWith(onAirTvList: r,onAirTvRequestState: RequestState.success))
      );
    });

    on<GetPopularTvEvent>((event, emit) async {
      final result=await getPopularTvUseCase(const NoParameter());
      result.fold(
              (l) => emit(state.copyWith(popularTvRequestState: RequestState.error,popularTvMessage: l.message)),
              (r) => emit(state.copyWith(popularTvList: r,popularTvRequestState: RequestState.success))
      );
    });

    on<GetTopRattedTvEvent>((event, emit) async {
      final result=await getTopRattedTvUseCase(const NoParameter());
      result.fold(
              (l) => emit(state.copyWith(topRatingTvRequestState: RequestState.error,topRatingTvMessage: l.message)),
              (r) => emit(state.copyWith(topRatingTvList: r,topRatingTvRequestState: RequestState.success))
      );
    });
  }
}
