import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en', '');

  Locale get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('selectedLanguage');

    // Set Thai as default if no language is selected
    _locale = Locale(languageCode ?? 'th', '');
    notifyListeners();
  }

  void setLocale(Locale locale) async {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('selectedLanguage', locale.languageCode);
    }
  }

  List<Locale> get supportedLocales => [
        const Locale('en', ''),
        const Locale('th', ''),
      ];
}

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode;

  ThemeProvider(this._isDarkMode);

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
