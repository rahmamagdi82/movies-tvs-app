import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app/di.dart';
import 'package:movies/components/components_manager.dart';
import 'package:movies/app/resource/string_manager.dart';
import 'package:movies/tv_module/pressentation/controller/tv_bloc/tv_bloc.dart';
import 'package:movies/tv_module/pressentation/screens/tv_details_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../app/enums.dart';
import '../../../app/resource/values_Manager.dart';

class PopularTvsScreen extends StatelessWidget{
  const PopularTvsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>instance<TvBloc>()..add(GetPopularTvEvent()),
      child: Scaffold(
        appBar: appBar(context,title: AppStrings.popularTvs),
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
      buildWhen: (previous,current)=>previous.popularTvRequestState !=current.popularTvRequestState,
      builder: (BuildContext context, state) {
        switch(state.popularTvRequestState) {
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
                              builder: (context)=> TvDetailsScreen(id: state.popularTvList[index].id,)),
                          withNavBar: false,
                        );
                      },
                      child: tvItem(context, state.popularTvList[index]));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: AppSize.s16,);
                },
                itemCount: state.popularTvList.length,
              ),
            );
          case RequestState.error:
            return Center(child: Text(state.popularTvMessage.tr()));
        }
        },
    );
  }
}