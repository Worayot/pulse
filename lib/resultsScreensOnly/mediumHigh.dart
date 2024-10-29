// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Pulse/screens/HomeScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:Pulse/treatmentsOnly/MedHighResult.dart';

class MediumHighPage extends StatelessWidget {
  final int MEWs;

  const MediumHighPage({super.key, required this.MEWs});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Header(size, true),
            SizedBox(height: size.height * 0.03),
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
            SizedBox(height: size.height * 0.01),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xffFFDDEc),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                  Text(
                    S.of(context)!.texttotalScore,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: size.width * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: size.width * 0.25,
                        height: size.width * 0.25,
                        child: Image.asset(
                          'assets/images/cloud_sun.png', // Replace with your image path
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text(
                        MEWs.toString(), // This should be changeable based on the calculation.
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: size.width * 0.2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.25,
                        height: size.width * 0.25,
                        child: Image.asset(
                          'assets/images/cloud.png', // Replace with your image path
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  FaIcon(FontAwesomeIcons.solidFaceSadTear,
                      size: size.width * 0.26, color: Color(0xffFF8F50)),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    S.of(context)!.resultmediumHigh,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: size.width * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: size.height * 0.07,
                        width: size.width * 0.4,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MediumHighResultPage(MEWs: MEWs),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffe8a0bf),
                            textStyle: TextStyle(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            S.of(context)!.textnursing,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                        width: size.width * 0.4,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFFDEAC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text(
                            S.of(context)!.buttonbackToHome,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
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
