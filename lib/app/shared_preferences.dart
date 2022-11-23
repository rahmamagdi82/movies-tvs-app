import 'package:shared_preferences/shared_preferences.dart';

const PREFS_KEY_THEME = "PREFS_KEY_LOGIN";
const PREFS_KEY_LANG="PREFS_KEY_LANG";


class AppPrefs{
  SharedPreferences _sharedPreferences;
  AppPrefs(this._sharedPreferences);

  Future putData({
    required String key,
    required dynamic value
  }) async{
    if (value is bool) return await _sharedPreferences.setBool(key, value);
    if (value is int) return await _sharedPreferences.setInt(key, value);
    if (value is String) return await _sharedPreferences.setString(key, value);
    else return await _sharedPreferences.setDouble(key, value);
  }

  dynamic getData({
    required String key,
  }){
    return _sharedPreferences.get(key);
  }

  dynamic removeData({
    required String key,
  }){
    return _sharedPreferences.remove(key);
  }
}