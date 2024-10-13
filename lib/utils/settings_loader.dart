// lib/utils/settings_loader.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, dynamic>> loadSettings() async {
  String jsonString = await rootBundle.loadString('assets/settings.json');
  return json.decode(jsonString);
}
