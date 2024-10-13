// ignore_for_file: file_names, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Pulse/authenticate/dataLoader.dart';
import 'package:Pulse/functions/prefFunctions.dart';
import 'package:Pulse/services/user_service.dart';
import 'package:Pulse/themes/color.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({super.key});

  @override
  _SettingsUserPageState createState() => _SettingsUserPageState();
}

class _SettingsUserPageState extends State<UserAccount> {
  Map<String, String> userDetails = {};

  // final uid = FirebaseAuth.instance.currentUser!.uid.toString();

  String name = '';
  String surname = '';
  String email = '';
  String newName = '';
  String newSurname = '';
  String newContact = '';
  String nurseID = '';
  String contact = '';

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    userDetails = await loadUserDetails();
    setState(() {
      name = userDetails['Name'] ?? '';
      surname = userDetails['Last Name'] ?? '';
      email = userDetails['Email'] ?? '';
      nurseID = userDetails['Nurse ID'] ?? '';
      contact = userDetails['Contact Info'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.03),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Header(size, false),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(FontAwesomeIcons.backward),
                ),
                Text(
                  S.of(context)!.back,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.005),

            // User details container
            Container(
              padding: EdgeInsets.all(size.width * 0.03),
              decoration: BoxDecoration(
                color: forthColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.solidUser, size: size.width * 0.12),
                  SizedBox(width: size.width * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '$name $surname',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.07,
                              ),
                            ),
                            TextSpan(
                              text: '\n$email',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: size.width * 0.05,
                              ),
                            ),
                            TextSpan(
                              text: '\n${S.of(context)!.nurseID}: $nurseID',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: size.width * 0.05,
                              ),
                            ),
                            TextSpan(
                              text: '\n${S.of(context)!.contact}: $contact',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: size.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: size.height * 0.02),

            // Edit user details
            Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      _buildEditableSection(
                          context,
                          S.of(context)!.editUserDetail,
                          '*${S.of(context)!.tapToEdit}', () {
                        _editUserDetails();
                      }),
                      _buildNameSurname(size),
                    ],
                  ),
                )),

            SizedBox(height: size.height * 0.02),
          ]),
        ),
      ),
    );
  }

  Widget _buildEditableSection(
      BuildContext context, String title, String hint, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.userPen,
              size: MediaQuery.of(context).size.width * 0.08,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: hint,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          color: const Color.fromARGB(255, 70, 70, 70),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameSurname(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (value) => newName = value,
          decoration: InputDecoration(
            hintText: S.of(context)!.textname,
            filled: true,
            fillColor: thirdColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.015),
        TextField(
          onChanged: (value) => newSurname = value,
          decoration: InputDecoration(
            hintText: S.of(context)!.textsurname,
            filled: true,
            fillColor: thirdColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.015),
        TextField(
          onChanged: (value) => newContact = value,
          decoration: InputDecoration(
            hintText: S.of(context)!.contact,
            filled: true,
            fillColor: thirdColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Row(
          children: [
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 191, 123, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(size.width * 0.05, size.height * 0.06),
                elevation: 0,
              ),
              onPressed: () async {
                await _editUserDetails();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      S.of(context)!.success,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserDataLoader()),
                );
              },
              child: Text(
                S.of(context)!.save,
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> _editUserDetails() async {
    if (newName.isNotEmpty || newSurname.isNotEmpty || newContact.isNotEmpty) {
      final success = await updateUserDetails(
        newName: newName.isNotEmpty ? newName : name,
        newSurname: newSurname.isNotEmpty ? newSurname : surname,
        newContact: newContact.isNotEmpty ? newContact : contact,
      );
      if (success) {
        String uid = FirebaseAuth.instance.currentUser!.uid.toString();
        UserService().updateProfile(
            uid: uid,
            name: newName,
            lastname: newSurname,
            contactInfo: newContact);
        setState(
          () {
            name = newName.isNotEmpty ? newName : name;
            surname = newSurname.isNotEmpty ? newSurname : surname;
            contact = newContact.isNotEmpty ? newContact : contact;
          },
        );
      }
    }
  }

  Future<bool> updateUserDetails({
    required String newName,
    required String newSurname,
    required String newContact,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text(S.of(context)!.ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context)!.success),
          content: Text(message),
          actions: [
            TextButton(
              child: Text(S.of(context)!.ok),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
