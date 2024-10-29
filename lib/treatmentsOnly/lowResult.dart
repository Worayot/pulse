// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/resultsScreensOnly/low.dart';
import 'package:Pulse/screens/HomeScreen.dart';
import 'package:Pulse/themes/components/header.dart';

class LowResultPage extends StatelessWidget {
  final int MEWs;
  const LowResultPage({
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
                  icon: FaIcon(FontAwesomeIcons.backward),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LowPage(
                                MEWs: MEWs,
                              )),
                    );
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
                          color: Color(0xffe8a0bf),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          S.of(context)!.textnursing,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff323232),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.04),
                  Text(
                    S.of(context)!.nursinglow,
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
                          backgroundColor: Color(0xffffdeac),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        },
                        child: Text(
                          S.of(context)!.buttonbackToHome,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
