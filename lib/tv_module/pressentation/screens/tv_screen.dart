import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app/di.dart';
import 'package:movies/components/components_manager.dart';
import 'package:movies/tv_module/pressentation/controller/tv_bloc/tv_bloc.dart';
import 'package:movies/tv_module/pressentation/screens/popular_tvs_screen.dart';
import 'package:movies/tv_module/pressentation/screens/top_ratted_tvs_screen.dart';
import 'package:movies/tv_module/pressentation/screens/tv_details_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../app/enums.dart';
import '../../../app/resource/color_manager.dart';
import '../../../app/resource/constants.dart';
import '../../../app/resource/string_manager.dart';
import '../../../app/resource/values_Manager.dart';

class TvScreen extends StatelessWidget {
  const TvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) =>instance<TvBloc>()..add(GetOnAirTvEvent())..add(GetPopularTvEvent())..add(GetTopRattedTvEvent()),
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                _getNowPlayingMoviesWidget(context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                  child: Row(
                    children: [
                      Text(
                        AppStrings.popular.tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          PersistentNavBarNavigator.pushDynamicScreen(
                            context,
                            screen: MaterialPageRoute(
                                builder: (context)=>const PopularTvsScreen()),
                            withNavBar: false,
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              AppStrings.seeMore.tr(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _getPopularMoviesWidget(context),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
                  child: Row(
                    children: [
                      Text(
                        AppStrings.topRated.tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          PersistentNavBarNavigator.pushDynamicScreen(
                            context,
                            screen: MaterialPageRoute(
                                builder: (context)=>const TopRattedTvsScreen()),
                            withNavBar: false,
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              AppStrings.seeMore.tr(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _getTopRatedMoviesWidget(context),
              ],
            ),
          ),
        ),
    );

  }

  Widget _getNowPlayingMoviesWidget(context) {
    return BlocBuilder<TvBloc,TvState>(
      buildWhen: (previous, current)=>previous.onAirTvRequestState != current.onAirTvRequestState,
      builder: (BuildContext context, state) {
        switch(state.onAirTvRequestState) {
          case RequestState.loading:
            return const SizedBox(
              height: AppSize.s350,
              child: Center(
                  child: CircularProgressIndicator()
              ),
            );
          case RequestState.success:
            return CarouselSlider(
              items: state.onAirTvList
                  .map(
                    (tv) => InkWell(
                  onTap: (){
                    PersistentNavBarNavigator.pushDynamicScreen(
                      context,
                      screen: MaterialPageRoute(
                          builder: (context)=>TvDetailsScreen(id: tv.id)),
                      withNavBar: false,
                    );
                  },
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                // fromLTRB
                                ColorManager.black,
                                ColorManager.black,
                                ColorManager.black,
                                Colors.transparent,
                              ],
                              stops: const [0, 0.3, 0.5, 1],
                            ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height),
                            );
                          },
                          blendMode: BlendMode.dstIn,
                          child: CachedNetworkImage(
                            imageUrl: '${AppConstants.baseImagePath}${tv.backdropPath}',
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => const Icon(Icons.error,size: AppSize.s40,),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: AppSize.s6,
                                backgroundColor: ColorManager.red,
                              ),
                              const SizedBox(
                                width: AppSize.s4,
                              ),
                              Text(
                                AppStrings.onAir.tr().toUpperCase(),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppSize.s8,
                          ),
                          Text(
                            tv.name.tr(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSize.s18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
                  .toList(),
              options: CarouselOptions(
                viewportFraction: AppSize.s1,
                autoPlay: false,
                height: AppSize.s350,
                enableInfiniteScroll: true,
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: AppSize.s170,
              child: Text(state.onAirTvMessage.tr()),
            );
        }
      },
    );
  }

  Widget _getPopularMoviesWidget(context) {
    return BlocBuilder<TvBloc,TvState>(
      buildWhen: (previous, current)=>previous.popularTvRequestState != current.popularTvRequestState,
      builder: (BuildContext context, state) {
        switch(state.popularTvRequestState) {
          case RequestState.loading:
            return const SizedBox(
              height: AppSize.s170,
              child: Center(
                  child: CircularProgressIndicator()
              ),
            );
          case RequestState.success:
            return SizedBox(
              height: AppSize.s170,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                    onTap: (){
                      PersistentNavBarNavigator.pushDynamicScreen(
                        context,
                        screen: MaterialPageRoute(
                            builder: (context)=> TvDetailsScreen(id: state.popularTvList[index].id,)),
                        withNavBar: false,
                      );
                    },
                      child: imageWidget("${state.popularTvList[index].backdropPath}")),
                  separatorBuilder: (context, index) => Container(
                    width: AppSize.s12,
                  ),
                  itemCount: state.popularTvList.length),
            );
          case RequestState.error:
            return SizedBox(
              height: AppSize.s170,
              child: Text(state.popularTvMessage.tr()),
            );
        }
      },
    );
  }

  Widget _getTopRatedMoviesWidget(context) {
    return BlocBuilder<TvBloc,TvState>(
      buildWhen: (previous, current)=>previous.topRatingTvRequestState != current.topRatingTvRequestState,
      builder: (BuildContext context, state) {
        switch(state.topRatingTvRequestState) {
          case RequestState.loading:
            return const SizedBox(
              height: AppSize.s170,
              child: Center(
                  child: CircularProgressIndicator()
              ),
            );
          case RequestState.success:
            return SizedBox(
              height: AppSize.s170,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                    onTap: (){
                        PersistentNavBarNavigator.pushDynamicScreen(
                          context,
                          screen: MaterialPageRoute(
                              builder: (context)=> TvDetailsScreen(id: state.topRatingTvList[index].id,)),
                          withNavBar: false,
                        );
                    },
                      child: imageWidget("${state.topRatingTvList[index].backdropPath}",)),
                  separatorBuilder: (context, index) => Container(
                    width: AppSize.s12,
                  ),
                  itemCount: state.topRatingTvList.length),
            );
          case RequestState.error:
            return SizedBox(
              height: AppSize.s170,
              child: Text(state.topRatingTvMessage.tr()),
            );
        }
      },
    );
  }

}
