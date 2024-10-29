// ignore_for_file: prefer_const_constructors, deprecated_member_use, non_constant_identifier_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Pulse/resultsScreensOnly/lowMedium.dart';
import 'package:Pulse/screens/HomeScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/themes/components/header.dart';

class LowMediumResultPage extends StatelessWidget {
  final int MEWs;
  const LowMediumResultPage({
    super.key,
    required this.MEWs,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Header(size, true),
            Row(
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.arrowLeft),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LowMediumPage(MEWs: MEWs),
                        ));
                  },
                ),
                Text(
                  S.of(context)!.back,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  S.of(context)!.descriptionscoreUpdate,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: size.width * 0.033,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xffFFDDEC),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.solidCircleCheck,
                          size: size.width * 0.1),
                      SizedBox(width: size.width * 0.02),
                      Container(
                        margin: EdgeInsets.only(left: size.width * 0.05),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Color(0xffE8A0BF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          S.of(context)!.textnursing,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.04),
                  Text(
                    S.of(context)!.nursinglowMedium,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: size.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFFDEAC),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context)!.buttonbackToHome,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
