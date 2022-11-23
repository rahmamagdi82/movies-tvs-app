import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:movies/screens/splash_view.dart';
import 'package:movies/setting_module/controller/setting_bloc.dart';
import 'app/enums.dart';
import 'app/resource/language_manager.dart';
import 'app/resource/theme_manager.dart';
import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      supportedLocales: const [ENGLISH_LOCAL,ARABIC_LOCAL],
      path: ASSET_PATH_LOCALIZATIONS,
      child: Phoenix(child: const MyApp())),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
 build(BuildContext context)   {
    return BlocProvider(
      create: (BuildContext context) => instance<SettingBloc>()..getTheme(),
      child: BlocBuilder<SettingBloc,SettingState>(
        buildWhen: (previous,current)=>previous.themeType !=current.themeType,
        builder: (BuildContext context, state) {
          switch(state.themeType) {
            case ThemeState.light:
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  theme: AppTheme.light,
                  darkTheme: AppTheme.dark,
                  themeMode: ThemeMode.light,
                  home: const SplashScreen()
              );
            case ThemeState.dark:
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  theme: AppTheme.light,
                  darkTheme: AppTheme.dark,
                  themeMode: ThemeMode.dark,
                  home: const SplashScreen()
              );
          }
        },
      ),
    );
  }
}