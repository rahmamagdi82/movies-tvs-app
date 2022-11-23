part of 'setting_bloc.dart';

class SettingState extends Equatable{
  final ThemeState themeType;
  final LanguageType languageType;

  const SettingState({
    this.themeType=ThemeState.light,
    this.languageType=LanguageType.english,
  });

  SettingState copyWith({
    ThemeState? themeType,
    LanguageType? languageType,
  }){
    return SettingState(
        themeType:themeType??this.themeType,
        languageType:languageType??this.languageType,
    );
  }

  @override
  List<Object?> get props => [
    themeType,
    languageType,
  ];
}