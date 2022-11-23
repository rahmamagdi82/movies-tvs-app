import 'package:flutter/material.dart';
import 'package:movies/app/enums.dart';

import '../di.dart';
import '../resource/font_manager.dart';
import '../resource/style_manager.dart';
import '../shared_preferences.dart';
import 'values_Manager.dart';
import 'color_manager.dart';

const String LIGHT="light";
const String DARK="dark";

class AppTheme {
  static ThemeData light = ThemeData(
        //background color
        backgroundColor: ColorManager.white,

        // highlightColor
        highlightColor: ColorManager.lightGray,

        // progress indicator color
        progressIndicatorTheme:
        ProgressIndicatorThemeData(color: ColorManager.darkBlue),

        // scaffold color
        scaffoldBackgroundColor: ColorManager.white,

        // main colors
        primaryColor: ColorManager.darkBlue,

        //list Tile Theme
        listTileTheme: ListTileThemeData(
          tileColor: ColorManager.lightGray,
          iconColor: ColorManager.darkBlue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s8)),
          style: ListTileStyle.list,
        ),

        //appBar theme
        appBarTheme: AppBarTheme(
            centerTitle: true,
            color: Colors.black54,
            elevation: AppSize.s0,
            titleTextStyle: getSemiBoldStyle(
              fontSize: FontSize.s18,
              color: ColorManager.white,
            ),
            iconTheme: IconThemeData(
              size: AppSize.s20,
              color: ColorManager.white,
            )),

        //text theme
        textTheme: TextTheme(
          displaySmall: getBoldStyle(
              color: ColorManager.darkBlue, fontSize: FontSize.s14),
          headlineMedium: getSemiBoldStyle(
              color: ColorManager.darkBlue, fontSize: FontSize.s14),
          titleMedium: getMediumStyle(
              color: ColorManager.darkBlue, fontSize: FontSize.s16),
          labelLarge: getRegularStyle(color: ColorManager.darkBlue),
        ),

        // text button style
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStatePropertyAll(ColorManager.darkBlue))),

        // icon theme
        iconTheme: IconThemeData(color: ColorManager.darkBlue, size: AppSize.s20),

      // expansion tile theme
     expansionTileTheme: ExpansionTileThemeData(
       collapsedIconColor: ColorManager.black,
       collapsedTextColor: ColorManager.black,
      textColor: ColorManager.white,
      iconColor: ColorManager.white,
    )

      );

  static ThemeData dark = ThemeData(
        //background color
        backgroundColor: ColorManager.darkBlue,

        // highlightColor
        highlightColor: ColorManager.gray,

        // progress indicator color
        progressIndicatorTheme:
        ProgressIndicatorThemeData(color: ColorManager.white),

        // scaffold color
        scaffoldBackgroundColor: ColorManager.darkBlue,

        // main colors
        primaryColor: ColorManager.white,

        //list Tile Theme
        listTileTheme: ListTileThemeData(
          iconColor: ColorManager.white,
          tileColor: ColorManager.gray,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s8)),
          style: ListTileStyle.list,
        ),

        //appBar theme
        appBarTheme: AppBarTheme(
            centerTitle: true,
            color: Colors.black54,
            elevation: AppSize.s0,
            titleTextStyle: getSemiBoldStyle(
              fontSize: FontSize.s18,
              color: ColorManager.white,
            ),
            iconTheme: IconThemeData(
              size: AppSize.s20,
              color: ColorManager.white,
            )),

        //text theme
        textTheme: TextTheme(
          displaySmall:
          getBoldStyle(color: ColorManager.white, fontSize: FontSize.s14),
          headlineMedium:
          getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s14),
          titleMedium:
          getMediumStyle(color: ColorManager.white, fontSize: FontSize.s16),
          labelLarge: getRegularStyle(color: ColorManager.white),
        ),

        // text button style
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(ColorManager.white))),

        // icon theme
        iconTheme: IconThemeData(color: ColorManager.white, size: AppSize.s20),

      // expansion tile theme
      expansionTileTheme: ExpansionTileThemeData(
        collapsedIconColor: ColorManager.lightGray,
        collapsedTextColor: ColorManager.lightGray,
        textColor: ColorManager.white,
        iconColor: ColorManager.white,
      )
      );
}


