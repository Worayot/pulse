import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/authenticate/login.dart';
import 'package:Pulse/screens/HomeScreen.dart';
import 'package:Pulse/themes/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Pulse/services/user_service.dart';
import 'package:Pulse/functions/prefFunctions.dart';

class UserDataLoader extends StatefulWidget {
  const UserDataLoader({super.key});

  @override
  State<UserDataLoader> createState() => _UserDataLoaderState();
}

class _UserDataLoaderState extends State<UserDataLoader> {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  bool _isNavigating = false; // Flag to prevent multiple navigations

  Map<String, String> _userDetails = {
    'Name': '',
    'Last Name': '',
    'Email': '',
    'Nurse ID': '',
    'Contact Info': '',
  };

  String text = "Loading Data...";

  Future<void> _fetchUserDetails() async {
    // Prevent multiple navigation attempts
    if (_isNavigating) return;
    _isNavigating = true;

    if (uid == null) {
      print('User ID is null');
      // Await the navigation to ensure it completes
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      return;
    }

    try {
      final userDetails = await UserService().getUserDetails(uid!);

      if (!mounted) return; // Check if the widget is still mounted
      setState(() {
        _userDetails = {
          'Name': userDetails['name'] ?? '',
          'Last Name': userDetails['lastname'] ?? '',
          'Email': userDetails['email'] ?? '',
          'Nurse ID': userDetails['nurseID'] ?? '',
          'Contact Info': userDetails['contactInfo'] ?? '',
        };
      });

      await saveUserDetails(_userDetails);

      if (!mounted) return; // Check again before navigating
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print('Failed to fetch user details: $e');
    } finally {
      _isNavigating = false;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchUserDetails());
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              S.of(context)!.greeting,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
