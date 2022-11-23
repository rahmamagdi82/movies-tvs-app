import 'package:flutter/material.dart';

import '../../app/di.dart';
import '../enums.dart';
import '../shared_preferences.dart';



const String ENGLISH="en-US";
const String ARABIC="ar-SA";
const String ASSET_PATH_LOCALIZATIONS="assets/translation";

const Locale ENGLISH_LOCAL= Locale("en","US");
const Locale ARABIC_LOCAL= Locale("ar","SA");

extension LanguageTypeExtention on LanguageType{
  String getValue(){
    switch(this){
      case LanguageType.english:
        return ENGLISH;
      case LanguageType.arabic:
        return ARABIC;
    }
  }
}

final AppPrefs _appPrefs=instance<AppPrefs>();
 String getAppLanguage()  {
  String? language =  _appPrefs.getData(key: PREFS_KEY_LANG);
  if (language != null) {
    if(language == ENGLISH){
      return LanguageType.english.getValue();
    }else
    {
      return LanguageType.arabic.getValue();
    }
  } else {
    // return default lang
    return LanguageType.english.getValue();
  }
}

Future<Locale> getLocal() async {
  String currentLang = await getAppLanguage();
  if (currentLang == LanguageType.arabic.getValue()) {
    return ARABIC_LOCAL;
  } else {
    return ENGLISH_LOCAL;
  }
}