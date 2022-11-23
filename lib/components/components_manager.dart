import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies/app/resource/values_Manager.dart';
import 'package:shimmer/shimmer.dart';

import '../../app/resource/constants.dart';
import '../../app/resource/color_manager.dart';
import '../../app/resource/font_manager.dart';
import '../movie_module/domain/entities/movie.dart';
import '../tv_module/domain/entities/tv.dart';

AppBar appBar(
    context,
    {String title = '',
    Color? color}
    ){
  return AppBar(
    backgroundColor: color,
    leading: IconButton(
      icon:const Icon(Icons.arrow_back_ios,),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    title: Text(title.tr()),
  );
}

Widget movieItem(context,Movie movie){
  return Container(
    decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(AppSize.s12)
    ),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Container(
              height: AppSize.s170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child:CachedNetworkImage(
                  imageUrl: "${AppConstants.baseImagePath}${movie.backdropPath}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: ColorManager.primary,
                    highlightColor: Colors.grey[700]!,
                    child: Container(
                      height: AppSize.s170,
                      width: AppSize.s120,
                      decoration: BoxDecoration(
                        color: ColorManager.black,
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error,size: AppSize.s40,)
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: AppSize.s8,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppPadding.p4),
                    decoration: BoxDecoration(
                        color: ColorManager.red,
                        borderRadius: BorderRadius.circular(AppSize.s4)),
                    child: Text(
                      movie.releaseDate.tr(),
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
                    "${movie.voteAverage}".tr(),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
              const SizedBox(
                height: AppSize.s12,
              ),
              Text(
                movie.overview.tr(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: FontSize.s12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget tvItem(context,Tv tv){
  return Container(
    decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(AppSize.s12)
    ),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Container(
              height: AppSize.s170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child:CachedNetworkImage(
                  imageUrl: "${AppConstants.baseImagePath}${tv.backdropPath}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: ColorManager.primary,
                    highlightColor: Colors.grey[700]!,
                    child: Container(
                      height: AppSize.s170,
                      width: AppSize.s120,
                      decoration: BoxDecoration(
                        color: ColorManager.black,
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error,size: AppSize.s40,)
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tv.name,
                style: Theme.of(context).textTheme.headlineMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: AppSize.s8,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppPadding.p4),
                    decoration: BoxDecoration(
                        color: ColorManager.red,
                        borderRadius: BorderRadius.circular(AppSize.s4)),
                    child: Text(
                      tv.firstAirDate.tr(),
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
                    "${tv.voteAverage}".tr(),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
              const SizedBox(
                height: AppSize.s12,
              ),
              Text(
                tv.overView.tr(),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: FontSize.s12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget imageWidget(String image, {double? width=AppSize.s120, double? height=AppSize.s170}){
  return Container(
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(AppSize.s12),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child:CachedNetworkImage(
        imageUrl: "${AppConstants.baseImagePath}$image",
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: ColorManager.primary,
          highlightColor: Colors.grey[700]!,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: ColorManager.black,
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error,size: AppSize.s40,)
    ),
  );
}