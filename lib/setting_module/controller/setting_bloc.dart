
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:movies/app/resource/language_manager.dart';

import '../../app/di.dart';
import '../../app/enums.dart';
import '../../app/resource/theme_manager.dart';
import '../../app/shared_preferences.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final AppPrefs appPrefs=instance<AppPrefs>();

  SettingBloc() : super(const SettingState()) {

    on<ChangeThemeAppEvent>((event, emit) async {
      if(event.mode == LIGHT){
        await appPrefs.putData(key: PREFS_KEY_THEME, value: event.mode);
        emit(state.copyWith(themeType: ThemeState.light));
      }else
        {
          await appPrefs.putData(key: PREFS_KEY_THEME, value: event.mode);
          emit(state.copyWith(themeType: ThemeState.dark));
        }
    });

    on<ChangeLanguageAppEvent>((event, emit) async {
      if(await appPrefs.getData(key: PREFS_KEY_LANG) != event.language){
        if(event.language == LanguageType.arabic.getValue()){
          event.context.setLocale(ARABIC_LOCAL);
          await appPrefs.putData(key: PREFS_KEY_LANG, value: event.language);
          emit(state.copyWith(languageType: LanguageType.arabic));
          Phoenix.rebirth(event.context);
        }else
        {
          event.context.setLocale(ENGLISH_LOCAL);
          await appPrefs.putData(key: PREFS_KEY_LANG, value: event.language);
          emit(state.copyWith(languageType: LanguageType.english));
          Phoenix.rebirth(event.context);
        }
      }

    });
  }

  void getTheme() async {
  if(await appPrefs.getData(key: PREFS_KEY_THEME) == DARK){
    emit(state.copyWith(themeType: ThemeState.dark));
    }else
      {
        emit(state.copyWith(themeType: ThemeState.light));
      }
  }

}
