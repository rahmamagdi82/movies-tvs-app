import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app/resource/string_manager.dart';
import 'package:movies/app/resource/theme_manager.dart';
import 'package:movies/app/resource/values_Manager.dart';
import 'package:movies/setting_module/controller/setting_bloc.dart';

import '../../app/enums.dart';
import '../../app/resource/language_manager.dart';


class SettingScreen extends StatelessWidget{
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(title: Text(AppStrings.settings.tr())),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  child: Column(
                    children: [
                      _getChangeTheme(),
                      const SizedBox(height: AppSize.s8),
                      _getChangeLanguage(),
                    ],
                  ),
                ),
              ),
            );

  }

  Widget _getChangeTheme(){
    return BlocBuilder<SettingBloc,SettingState>(
      builder: (BuildContext context, state)
    {
      return ExpansionTile(
        leading: const Icon(Icons.brightness_medium_outlined),
        title: Text(AppStrings.appMode.tr()),
        children: [
          ListTile(
            tileColor: Theme
                .of(context)
                .backgroundColor,
            leading: const Icon(Icons.light_mode),
            title: Text(AppStrings.lightMode.tr()),
            onTap: () {
              context.read<SettingBloc>().add(const ChangeThemeAppEvent(LIGHT));
            },
          ),
          ListTile(
            tileColor: Theme
                .of(context)
                .backgroundColor,
            leading: const Icon(Icons.dark_mode),
            title: Text(AppStrings.darkMode.tr()),
            onTap: () {
              context.read<SettingBloc>().add(const ChangeThemeAppEvent(DARK));
            },
          ),
        ],
      );
    }
    );
  }

  Widget _getChangeLanguage(){
    return BlocBuilder<SettingBloc,SettingState>(
        builder: (BuildContext context, state)
        {
          return ExpansionTile(
            leading: const Icon(Icons.language),
            title: Text(AppStrings.language.tr()),
            children:  [
              ListTile(
                tileColor: Theme.of(context).backgroundColor,
                title: Text(AppStrings.arabic.tr()),
                onTap: () async {
                  context.read<SettingBloc>().add(ChangeLanguageAppEvent(context,LanguageType.arabic.getValue()));
                },
              ),
              ListTile(
                tileColor: Theme.of(context).backgroundColor,
                title: Text(AppStrings.english.tr()),
                onTap: (){
                  context.read<SettingBloc>().add(ChangeLanguageAppEvent(context,LanguageType.english.getValue()));
                },
              ),
            ],
          );
        }
    );
  }
}