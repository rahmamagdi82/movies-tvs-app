import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_module/pressentation/controller/movie_details_bloc/movie_details_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../components/components_manager.dart';
import '../../../app/resource/constants.dart';
import '../../../app/di.dart';
import '../../../app/enums.dart';
import '../../../app/resource/color_manager.dart';
import '../../../app/resource/font_manager.dart';
import '../../../app/resource/string_manager.dart';
import '../../../app/resource/values_Manager.dart';

class MovieDetailsScreen extends StatelessWidget {
  int id;
  MovieDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => instance<MovieDetailsBloc>()
        ..add(GetMovieDetailsEvent(id))
        ..add(GetRecommendationMoviesEvent(id)),
      child: Scaffold(
        appBar:  appBar(context,color: Colors.transparent),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getMovieDetailsWidget(context),
              const SizedBox(height: AppSize.s30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                child: Text(
                  AppStrings.moreLikeThis.tr().toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              _getLikeThisWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMovieDetailsWidget(context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      buildWhen: (previous, current)=>previous.movieDetailsState!=current.movieDetailsState,
      builder: (BuildContext context, state) {
        switch (state.movieDetailsState) {
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
                          '${AppConstants.baseImagePath}${state.movieDetails?.backdropPath}',
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Text(
                    state.movieDetails!.title.tr(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ).tr(),
                ),
                const SizedBox(height: AppSize.s12),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppPadding.p4),
                        decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(AppSize.s4)),
                        child: Text(
                          state.movieDetails!.releaseDate.tr(),
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
                        "${state.movieDetails!.voteAverage}".tr(),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(
                        width: AppSize.s30,
                      ),
                      Text(
                        calculateRunTime(state.movieDetails!.runTime),
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
                    state.movieDetails!.overview.tr(),
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
                              for (int i = 0; i < state.movieDetails!.genres.length; i++)
                                if(i != state.movieDetails!.genres.length -1)
                                Text(
                                  " ${state.movieDetails!.genres[i].name},".tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(color: ColorManager.lightGray),
                                ),
                              Text(
                                " ${state.movieDetails!.genres.last.name}".tr(),
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
              child: Text(state.movieDetailsMessage.tr()),
            );
        }
      },
    );
  }

  Widget _getLikeThisWidget() {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      buildWhen: (previous, current)=>previous.recommendationMoviesRequestState != current.recommendationMoviesRequestState,
      builder: (BuildContext context, state) {
        switch (state.recommendationMoviesRequestState) {
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
                padding: const EdgeInsets.all( AppPadding.p0),
                crossAxisCount: 3,
                crossAxisSpacing: AppSize.s6,
                mainAxisSpacing: AppSize.s6,
                childAspectRatio: 0.6,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(state.recommendationMoviesList.length,
                    (index) {
                  return InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushDynamicScreen(
                        context,
                        screen: MaterialPageRoute(
                            builder: (context)=> MovieDetailsScreen(id: state.recommendationMoviesList[index].id,)),
                        withNavBar: false,
                      );
                    },
                    child: imageWidget("${state.recommendationMoviesList[index].backdropPath}",height: AppSize.s0,width: AppSize.s0),
                  );
                }),
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: AppSize.s170,
              child: Text(state.recommendationMoviesMessage.tr()),
            );
        }
      },
    );
  }

  String calculateRunTime(int runTime) {
    int minute = 0;
    int hours = runTime ~/ 60;
    runTime -= hours * 60;
    if (runTime > 60) {
      minute = runTime ~/ 60;
    }
    minute = runTime;
    return '$hours${AppStrings.hour.tr()} $minute${AppStrings.minute.tr()}';
  }
}
