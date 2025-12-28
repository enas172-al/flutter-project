import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/constants/app_color.dart';
import 'features/profile/view/providers/theme_provider.dart';
import 'features/profile/view/providers/locale_provider.dart';
import 'features/welcome/view/welcome_screen.dart';

import 'l10n/app_localizations.dart' show AppLocalizations;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localeProvider = LocaleProvider();
  await localeProvider.loadLocale();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: localeProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      locale: localeProvider.locale,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],


      themeMode: themeProvider.themeMode,

      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Cairo',
        primaryColor: AppColors.primary,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Cairo',
        primaryColor: AppColors.primary,
      ),

      home: const WelcomeScreen(),
    );
  }
}
