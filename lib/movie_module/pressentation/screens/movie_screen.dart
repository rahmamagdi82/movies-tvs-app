import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app/resource/constants.dart';
import 'package:movies/app/di.dart';
import 'package:movies/movie_module/pressentation/controller/movies_bloc/movies_bloc.dart';
import 'package:movies/movie_module/pressentation/controller/movies_bloc/movies_event.dart';
import 'package:movies/movie_module/pressentation/controller/movies_bloc/movies_state.dart';
import 'package:movies/movie_module/pressentation/screens/popular_movies_screen.dart';
import 'package:movies/movie_module/pressentation/screens/top_ratting_movies_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../app/enums.dart';
import '../../../app/resource/color_manager.dart';
import '../../../components/components_manager.dart';
import '../../../app/resource/string_manager.dart';
import '../../../app/resource/values_Manager.dart';
import 'movie_details_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>instance<MovieBloc>()..add(GetPlayingNowMoviesEvent())..add(GetPopularMoviesEvent())..add(GetTopRatingNowMoviesEvent()),
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
                                  builder: (context)=>const PopularMoviesScreen()),
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
                                  builder: (context)=>const TopRattingMoviesScreen()),
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
    return BlocBuilder<MovieBloc,MoviesState>(
      buildWhen: (previous, current)=>previous.nowPlayingRequestState != current.nowPlayingRequestState,
      builder: (BuildContext context, state) {
        switch(state.nowPlayingRequestState) {
          case RequestState.loading:
            return const SizedBox(
              height: AppSize.s350,
                child: Center(
                    child: CircularProgressIndicator()
                ),
            );
          case RequestState.success:
            return CarouselSlider(
              items: state.nowPlayingMoviesList
                  .map(
                    (movie) => InkWell(
                      onTap: (){
                        PersistentNavBarNavigator.pushDynamicScreen(
                          context,
                          screen: MaterialPageRoute(
                              builder: (context)=>MovieDetailsScreen(id: movie.id,)),
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
                            imageUrl: '${AppConstants.baseImagePath}${movie.backdropPath}',
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
                                AppStrings.nowPlaying.tr().toUpperCase(),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: AppSize.s8,
                          ),
                          Text(
                            movie.title.tr(),
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
                child: Text(state.nowPlayingMessage.tr()),
              );
        }
      },
    );
  }

  Widget _getPopularMoviesWidget(context) {
    return BlocBuilder<MovieBloc,MoviesState>(
      buildWhen: (previous, current)=>previous.popularRequestState != current.popularRequestState,
      builder: (BuildContext context, state) {
        switch(state.popularRequestState) {
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
                                builder: (context)=> MovieDetailsScreen(id: state.popularMoviesList[index].id,)),
                            withNavBar: false,
                          );
                        },
                          child: imageWidget(state.popularMoviesList[index].backdropPath)
                      ),
                      separatorBuilder: (context, index) => Container(
                        width: AppSize.s12,
                      ),
                      itemCount: state.popularMoviesList.length),
                );
          case RequestState.error:
            return SizedBox(
              height: AppSize.s170,
              child: Text(state.popularMessage.tr()),
            );
        }
      },
    );
  }

  Widget _getTopRatedMoviesWidget(context) {
    return BlocBuilder<MovieBloc,MoviesState>(
      buildWhen: (previous, current)=>previous.topRatingRequestState != current.topRatingRequestState,
      builder: (BuildContext context, state) {
        switch(state.topRatingRequestState) {
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
                              builder: (context)=> MovieDetailsScreen(id: state.topRatingMoviesList[index].id,)),
                          withNavBar: false,
                        );
                      },
                      child: imageWidget(state.topRatingMoviesList[index].backdropPath)
                  ),
                  separatorBuilder: (context, index) => Container(
                    width: AppSize.s12,
                  ),
                  itemCount: state.topRatingMoviesList.length),
            );
          case RequestState.error:
            return SizedBox(
              height: AppSize.s170,
              child: Text(state.topRatingMessage),
            );
        }
      },
    );
  }

}