import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/tv_module/pressentation/screens/season.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../components/components_manager.dart';
import '../../../app/resource/constants.dart';
import '../../../app/di.dart';
import '../../../app/enums.dart';
import '../../../app/resource/color_manager.dart';
import '../../../app/resource/font_manager.dart';
import '../../../app/resource/string_manager.dart';
import '../../../app/resource/values_Manager.dart';
import '../controller/details_tv_bloc/details_tv_bloc.dart';

class TvDetailsScreen extends StatelessWidget {
  int id;
  TvDetailsScreen({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => instance<DetailsTvBloc>()
        ..add(GetTvDetailsEvent(id))..add(const GetShowEvent(true, false)),
      child: Scaffold(
        appBar: appBar(context,color: Colors.transparent),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getMovieDetailsWidget(context),
              const SizedBox(height: AppSize.s30),
              _getSelectWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMovieDetailsWidget(context) {
    return BlocBuilder<DetailsTvBloc, DetailsTvState>(
      buildWhen: (previous, current)=>previous.tvDetailsState!=current.tvDetailsState,
      builder: (BuildContext context, state) {
        switch (state.tvDetailsState) {
          case RequestState.loading:
            return const SizedBox(
              height: AppSize.s350,
              child: Center(
                  child: CircularProgressIndicator()),
            );
          case RequestState.success:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: AppSize.s270,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [
                          // fromLTRB
                          ColorManager.black,
                          ColorManager.black,
                        ],
                        stops: const [0, 0.6],
                      ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height),
                      );
                    },
                    blendMode: BlendMode.dstIn,
                    child: CachedNetworkImage(
                      imageUrl:
                      '${AppConstants.baseImagePath}${state.tvDetails?.backdropPath}',
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        size: AppSize.s40,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Text(
                    state.tvDetails!.name.tr(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: AppSize.s12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Wrap(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppPadding.p4),
                        decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(AppSize.s4)),
                        child: Text(
                          state.tvDetails!.firstAirDate.tr(),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      const SizedBox(
                        width: AppSize.s18,
                      ),
                      Icon(
                        Icons.star,
                        color: ColorManager.yellow,
                      ),
                      const SizedBox(
                        width: AppSize.s4,
                      ),
                      Text(
                        "${state.tvDetails!.voteAverage}".tr(),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(
                        width: AppSize.s30,
                      ),
                      Text(
                        "${state.tvDetails!.numberOfSeasons} ${AppStrings.seasons.tr()}",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: ColorManager.lightGray),
                      ),
                      const SizedBox(
                        width: AppSize.s16,
                      ),
                      Text(
                        (state.tvDetails!.episodeRunTime.isEmpty)?"0${AppStrings.minute.tr()}":"${state.tvDetails!.episodeRunTime.first}${AppStrings.minute.tr()}",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: ColorManager.lightGray),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s27),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Text(
                    state.tvDetails!.overView.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(fontSize: FontSize.s12),
                  ),
                ),
                const SizedBox(height: AppSize.s12),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.genres.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: ColorManager.lightGray),
                        ),
                        Expanded(
                          child: Wrap(
                            children: [
                              for (int i = 0; i < state.tvDetails!.genres.length; i++)
                                if(i != state.tvDetails!.genres.length -1)
                                  Text(
                                    " ${state.tvDetails!.genres[i].name},".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: ColorManager.lightGray),
                                  ),
                              if(state.tvDetails!.genres.isNotEmpty)
                              Text(
                                " ${state.tvDetails!.genres.last.name}".tr(),
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: ColorManager.lightGray
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ],
            );
          case RequestState.error:
            return SizedBox(
              height: AppSize.s170,
              child: Text(state.tvDetailsMessage.tr()),
            );
        }
      },
    );
  }

  Widget _getSelectWidget(context){
    return BlocBuilder<DetailsTvBloc,DetailsTvState>(
      builder: (BuildContext context, state) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      if(state.showDetailsWidget)
                      Container(
                        width: double.infinity,
                        height: AppSize.s3,
                        color: ColorManager.red,
                      ),
                      TextButton(
                          onPressed: (){
                            context.read<DetailsTvBloc>().add(const GetShowEvent(true, false));
                          },
                          child: Text(
                            AppStrings.episodes.tr().toUpperCase(),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      if(state.showRecommendationWidget)
                      Container(
                        width: double.infinity,
                        height: AppSize.s3,
                        color: ColorManager.red,
                      ),
                      TextButton(
                          onPressed: (){
                            context.read<DetailsTvBloc>().add(const GetShowEvent(false, true));
                            context.read<DetailsTvBloc>().add(GetRecommendationTvEvent(id));
                          },
                          child: Text(
                            AppStrings.moreLikeThis.tr().toUpperCase(),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if(state.showRecommendationWidget)
              _getLikeThisWidget(),
            if(state.showDetailsWidget)
              _getSeasonsWidget(),
          ],
        );
      },
    );
  }

  Widget _getSeasonsWidget() {
    return BlocBuilder<DetailsTvBloc,DetailsTvState>(
      buildWhen: (previous,current)=>previous.tvDetailsState != current.tvDetailsState,
      builder: (BuildContext context, state) {
        switch (state.tvDetailsState) {
          case RequestState.loading:
            return const SizedBox(
              height: AppSize.s350,
              child: Center(
                  child: CircularProgressIndicator()),
            );
          case RequestState.success:
            return ListView.separated(
              padding: const EdgeInsets.all(AppPadding.p16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {
                return ExpansionTile(
                  title: Text("${AppStrings.season.tr()} ${index + 1}"),
                  children: [
                    SeasonScreen(id: id, seasonNumber: index + 1,),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(height: AppSize.s14,);
              },
              itemCount: state.tvDetails!.numberOfSeasons,
            );
          case RequestState.error:
            return SizedBox(
              height: AppSize.s170,
              child: Text(state.tvDetailsMessage.tr()),
            );
        }
      },
    );
  }

  Widget _getLikeThisWidget() {
    return BlocBuilder<DetailsTvBloc, DetailsTvState>(
      buildWhen: (previous, current)=>previous.recommendationTvRequest != current.recommendationTvRequest,
      builder: (BuildContext context, state) {
        switch (state.recommendationTvRequest) {
          case RequestState.loading:
            return const SizedBox(
              height: AppSize.s350,
              child: Center(
                  child: CircularProgressIndicator()),
            );
          case RequestState.success:
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: GridView.count(
                padding: const EdgeInsets.all(AppPadding.p0),
                crossAxisCount: 3,
                crossAxisSpacing: AppSize.s6,
                mainAxisSpacing: AppSize.s6,
                childAspectRatio: 0.6,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(state.recommendationTvList.length,
                    (index) {
                  return InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushDynamicScreen(
                        context,
                        screen: MaterialPageRoute(
                            builder: (context)=> TvDetailsScreen(id: state.recommendationTvList[index].id,)),
                        withNavBar: false,
                      );
                    },
                     child: imageWidget(
                         "${state.recommendationTvList[index].backdropPath}",height: AppSize.s0,width: AppSize.s0),
                  );
                }),
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: AppSize.s170,
              child: Text(state.recommendationTvMessage.tr()),
            );
        }
      },
    );
  }

}
