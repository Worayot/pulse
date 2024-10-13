import 'package:shared_preferences/shared_preferences.dart';

// Function to load user details from SharedPreferences
Future<Map<String, String>> loadUserDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return {
    'Name': prefs.getString('Name') ?? '',
    'Last Name': prefs.getString('Last Name') ?? '',
    'Email': prefs.getString('Email') ?? '',
    'Nurse ID': prefs.getString('Nurse ID') ?? '',
    'Contact Info': prefs.getString('Contact Info') ?? '',
  };
}

// Function to save user details to SharedPreferences
Future<void> saveUserDetails(Map<String, String> userDetails) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('Name', userDetails['Name'] ?? '');
  await prefs.setString('Last Name', userDetails['Last Name'] ?? '');
  await prefs.setString('Email', userDetails['Email'] ?? '');
  await prefs.setString('Nurse ID', userDetails['Nurse ID'] ?? '');
  await prefs.setString('Contact Info', userDetails['Contact Info'] ?? '');
}

Future<String> getUserName() async {
  Map<String, String> userDetails = await loadUserDetails();
  return userDetails['Name'] ??
      'Default Name'; // Provide a fallback name if not found
}

Future<String> getUserId() async {
  Map<String, String> userDetails = await loadUserDetails();
  return userDetails['Nurse ID'] ??
      'null'; // Provide a fallback name if not found
}

Future<void> checkUserDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('Name: ${prefs.getString('Name')}');
  print('Last Name: ${prefs.getString('Last Name')}');
  print('Email: ${prefs.getString('Email')}');
  print('Nurse ID: ${prefs.getString('Nurse ID')}');
  print('Contact Info: ${prefs.getString('Contact Info')}');
}

Future<void> delUserDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('Name', '');
  await prefs.setString('Last Name', '');
  await prefs.setString('Email', '');
  await prefs.setString('Nurse ID', '');
  await prefs.setString('Contact Info', '');
  ;
}
