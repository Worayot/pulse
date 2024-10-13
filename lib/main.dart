import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/authenticate/dataLoader.dart';
import 'package:Pulse/authenticate/login.dart';
import 'package:Pulse/screens/darkmode.dart';
import 'package:Pulse/screens/homeScreen.dart';
import 'package:provider/provider.dart';
import 'package:Pulse/screens/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Pulse/themes/theme.dart';
import 'provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? selectedLanguage = prefs.getString('selectedLanguage');
  bool isDarkMode = prefs.getBool('isDarkMode') ?? false;

  String defaultLocale = selectedLanguage ?? 'th';

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAjQjPHg7Gi-BbuTq4Fhp3EwlK6jfDv-Zk",
          authDomain: "mewsv1-d765c.firebaseapp.com",
          projectId: "mewsv1-d765c",
          storageBucket: "mewsv1-d765c.appspot.com",
          messagingSenderId: "935111585592",
          appId: "1:935111585592:web:6dfa42c441d92e6da69bcd",
          measurementId: "G-YNSHR01XEN"),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(isDarkMode)),
      ],
      child: MyApp(defaultLocale),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String defaultLocale;

  MyApp(this.defaultLocale);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Platform.isIOS
          ? CupertinoApp(
              theme: CupertinoThemeData(
                  brightness: themeProvider.isDarkMode
                      ? Brightness.dark
                      : Brightness.light),
              localizationsDelegates: const [
                S.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              locale: Provider.of<LocaleProvider>(context).locale,
              supportedLocales: S.supportedLocales,
              debugShowCheckedModeBanner: false,
              home: UserDataLoader(),
              routes: {
                '/home': (context) => HomeScreen(),
                '/login': (context) => LoginPage(),
                '/settings': (context) => SettingsPage(),
              },
            )
          : MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode:
                  themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: Provider.of<LocaleProvider>(context).locale,
              supportedLocales: S.supportedLocales,
              debugShowCheckedModeBanner: false,
              home: UserDataLoader(),
              routes: {
                '/home': (context) => HomeScreen(),
                '/login': (context) => LoginPage(),
                '/settings': (context) => SettingsPage(),
              },
            );
    });
  }
}
