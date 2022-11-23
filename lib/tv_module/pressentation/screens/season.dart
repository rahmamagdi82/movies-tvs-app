import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app/di.dart';
import 'package:movies/components/components_manager.dart';
import 'package:movies/tv_module/pressentation/controller/episode_bloc/episode_bloc.dart';

import '../../../app/enums.dart';
import '../../../app/resource/color_manager.dart';
import '../../../app/resource/font_manager.dart';
import '../../../app/resource/values_Manager.dart';

class SeasonScreen extends StatelessWidget{
  int id;
  int seasonNumber;
  SeasonScreen({super.key,required this.id,required this.seasonNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>instance<EpisodeBloc>()..add(GetSeasonTvEvent(id, seasonNumber)),
      child: _getEpisodesWidget(),
    );
  }

  Widget _getEpisodesWidget() {
    return BlocBuilder<EpisodeBloc,EpisodeState>(
      buildWhen: (previous,current)=>previous.seasonTvRequest != current.seasonTvRequest,
        builder: (context,state){
          switch (state.seasonTvRequest) {
            case RequestState.loading:
              return const SizedBox(
                height: AppSize.s350,
                child: Center(
                    child: CircularProgressIndicator()),
              );
            case RequestState.success:
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical:AppPadding.p8),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, int index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          imageWidget("${state.season!.episodes[index].stillPath}",height:AppSize.s100,width: AppSize.s170),
                          const SizedBox(width: AppSize.s8,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${state.season!.episodes[index].episodeNumber}.${state.season!.episodes[index].name}".tr(),
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                const SizedBox(
                                  height: AppSize.s8,
                                ),
                                Text(
                                  state.season!.episodes[index].airDate.tr(),
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(color: ColorManager.lightGray),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s8,),
                      Text(
                        state.season!.episodes[index].overView.tr(),
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: FontSize.s12,color: ColorManager.lightGray),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(height: AppSize.s14,);
                },
                itemCount: state.season!.episodes.length,
              );
            case RequestState.error:
              return SizedBox(
                height: AppSize.s170,
                child: Text(state.seasonTvMessage.tr()),
              );
          }
        });
  }

}