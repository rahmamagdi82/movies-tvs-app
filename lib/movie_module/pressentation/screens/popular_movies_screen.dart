import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app/di.dart';
import 'package:movies/movie_module/pressentation/controller/movies_bloc/movies_bloc.dart';
import 'package:movies/movie_module/pressentation/controller/movies_bloc/movies_event.dart';
import 'package:movies/movie_module/pressentation/controller/movies_bloc/movies_state.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../app/enums.dart';
import '../../../components/components_manager.dart';
import '../../../app/resource/string_manager.dart';
import '../../../app/resource/values_Manager.dart';
import 'movie_details_screen.dart';


class PopularMoviesScreen extends StatelessWidget{
  const PopularMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>instance<MovieBloc>()..add(GetPopularMoviesEvent()),
      child: Scaffold(
        appBar: appBar(context,title: AppStrings.popularMovies),
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getMovieWidget(),
            ],
          ),
        )
      ),
    );
  }

  Widget _getMovieWidget(){
    return BlocBuilder<MovieBloc,MoviesState>(
      buildWhen: (previous,current)=>previous.popularRequestState != current.popularRequestState,
      builder: (BuildContext context, state) {
        switch(state.popularRequestState) {
          case RequestState.loading:
            return const Center(
                child: CircularProgressIndicator()
            );
          case RequestState.success:
            return Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index){
                  return InkWell(
                      onTap: (){
                        PersistentNavBarNavigator.pushDynamicScreen(
                          context,
                          screen: MaterialPageRoute(
                              builder: (context)=> MovieDetailsScreen(id: state.popularMoviesList[index].id,)),
                          withNavBar: false,
                        );
                      },
                      child: movieItem(context, state.popularMoviesList[index]));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: AppSize.s16,);
                },
                itemCount: state.popularMoviesList.length,
              ),
            );
          case RequestState.error:
            return Center(child: Text(state.popularMessage.tr()));
        }
      },
    );
  }

}