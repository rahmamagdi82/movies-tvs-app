import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app/di.dart';
import 'package:movies/app/resource/string_manager.dart';
import 'package:movies/app/resource/values_Manager.dart';
import 'package:movies/tv_module/pressentation/controller/tv_bloc/tv_bloc.dart';
import 'package:movies/tv_module/pressentation/screens/tv_details_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../app/enums.dart';
import '../../../components/components_manager.dart';

class TopRattedTvsScreen extends StatelessWidget{
  const TopRattedTvsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>instance<TvBloc>()..add(GetTopRattedTvEvent()),
      child: Scaffold(
        appBar: appBar(context,title: AppStrings.topRatedTvs),
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getTvWidget(),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _getTvWidget(){
    return BlocBuilder<TvBloc,TvState>(
      buildWhen: (previous,current)=>previous.topRatingTvRequestState !=current.topRatingTvRequestState,
        builder:(context,state){
          switch(state.topRatingTvRequestState){
            case RequestState.loading:
              return const Center(child: CircularProgressIndicator());
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
                                builder: (context)=> TvDetailsScreen(id: state.topRatingTvList[index].id,)),
                            withNavBar: false,
                          );
                        },
                        child: tvItem(context, state.topRatingTvList[index]));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: AppSize.s16,);
                  },
                  itemCount: state.topRatingTvList.length,
                ),
              );
            case RequestState.error:
              return Center(child: Text(state.topRatingTvMessage.tr()));
          }
        }
    );
  }
}