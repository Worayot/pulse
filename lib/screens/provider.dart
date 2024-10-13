import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en', '');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!LocaleProvider.locales.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  static const List<Locale> locales = [Locale('en', ''), Locale('th', '')];
}
