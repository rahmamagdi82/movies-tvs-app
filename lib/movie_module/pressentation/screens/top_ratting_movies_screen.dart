import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movie_module/pressentation/controller/movies_bloc/movies_event.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../app/di.dart';
import '../../../app/enums.dart';
import '../../../components/components_manager.dart';
import '../../../app/resource/string_manager.dart';
import '../../../app/resource/values_Manager.dart';
import '../controller/movies_bloc/movies_bloc.dart';
import '../controller/movies_bloc/movies_state.dart';
import 'movie_details_screen.dart';


class TopRattingMoviesScreen extends StatelessWidget{
  const TopRattingMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>instance<MovieBloc>()..add(GetTopRatingNowMoviesEvent()),
      child: Scaffold(
          appBar: appBar(context, title:AppStrings.topRatedMovies),
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
      buildWhen: (previous,current)=>previous.topRatingRequestState != current.topRatingRequestState,
      builder: (BuildContext context, state) {
        switch(state.topRatingRequestState) {
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
                              builder: (context)=> MovieDetailsScreen(id: state.topRatingMoviesList[index].id,)),
                          withNavBar: false,
                        );
                      },
                      child: movieItem(context, state.topRatingMoviesList[index]));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: AppSize.s16,);
                },
                itemCount: state.topRatingMoviesList.length,
              ),
            );
          case RequestState.error:
            return Center(child: Text(state.topRatingMessage.tr()));
        }
      },
    );
  }

}