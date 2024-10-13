// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/functions/prefFunctions.dart';
import 'package:Pulse/screens/aboutApp.dart';
import 'package:Pulse/screens/aboutDevScreen.dart';
import 'package:Pulse/screens/language.dart';
import 'package:Pulse/screens/userAccount.dart';
import 'package:Pulse/services/auth_service.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:Pulse/themes/components/settingitem.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(size, false),
              Row(children: [
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
              ]),
              SizedBox(height: size.height * 0.04),
              // Settings items
              SettingsItem(
                title: S.of(context)!.userAccount,
                icon: Icons.account_circle,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserAccount()),
                  );
                },
              ),
              SettingsItem(
                title: S.of(context)!.aboutDev,
                icon: Icons.headset,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const aboutDev()),
                  );
                },
              ),
              SettingsItem(
                title: S.of(context)!.aboutApp,
                icon: Icons.help,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutApp()),
                  );
                },
              ),
              SettingsItem(
                title: S.of(context)!.languages,
                icon: Icons.language,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LanguageSettingScreen()),
                  );
                },
              ),
              SizedBox(height: size.height * 0.04),
              Center(
                child: TextButton(
                  onPressed: () async {
                    await delUserDetails();
                    AuthService().signout(context: context);
                  },
                  child: Text(
                    S.of(context)!.logout,
                    style: GoogleFonts.inter(
                      color: Colors.red,
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
