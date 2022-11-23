
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../app/enums.dart';
import '../../../domain/entities/season.dart';
import '../../../domain/usecase/tv_season_usecase.dart';

part 'episode_event.dart';
part 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final GetSeasonTvUseCase getSeasonTvUseCase;

  EpisodeBloc(this.getSeasonTvUseCase) : super(const EpisodeState()) {
    on<GetSeasonTvEvent>((event, emit) async {
      final result = await getSeasonTvUseCase.call(SeasonTvParameter(id: event.id, seasonNumber: event.seasonNumber));
      result.fold(
            (l) => emit(state.copyWith(seasonTvRequest: RequestState.error,seasonTvMessage: l.message)),
            (r) => emit(state.copyWith(season: r,seasonTvRequest: RequestState.success)),
      );
    });
  }
}
