part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();
}

class ChangeThemeAppEvent extends SettingEvent{
  final String mode;
  const ChangeThemeAppEvent(this.mode);
  @override
  List<Object?> get props => [
    mode
  ];
}

class ChangeLanguageAppEvent extends SettingEvent{
  final String language;
  final BuildContext context;
  const ChangeLanguageAppEvent(this.context, this.language);
  @override
  List<Object?> get props => [
    language,
    context
  ];
}