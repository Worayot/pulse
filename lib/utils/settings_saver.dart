// lib/utils/settings_saver.dart
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLanguageSetting(String language) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('language', language);
}
