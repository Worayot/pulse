// ignore_for_file: prefer_const_constructors, deprecated_member_use, sized_box_for_whitespace

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Pulse/analysis/updatePatientScreen.dart';
import 'package:Pulse/treatments/lowResult.dart';
import 'package:Pulse/screens/homeScreen.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LowPage extends StatelessWidget {
  final int MEWs;
  final String patientID;

  const LowPage({
    super.key,
    required this.MEWs,
    required this.patientID,
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
            SizedBox(height: size.height * 0.008),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xffFFDDEC),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                  Text(
                    S.of(context)!.texttotalScore,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: size.width * 0.085,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Container(
                          width: size.width * 0.3, // Increase the width
                          height: size.width * 0.3, // Increase the height
                          child: Image.asset(
                            'assets/images/sun-cloud.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          MEWs.toString(), // This should be changeable based on the calculation.
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontSize: size.width * 0.2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          width: size.width * 0.3, // Increase the width
                          height: size.width * 0.3, // Increase the height
                          child: Image.asset(
                            'assets/images/clouds.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.015),
                  FaIcon(
                    FontAwesomeIcons.solidSmileBeam,
                    color: Color.fromARGB(255, 153, 227, 55),
                    size: size.width * 0.26,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    S.of(context)!.resultlow,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: size.width * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          S.of(context)!.textnursing,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LowResultPage(
                                    MEWs: MEWs, patientID: patientID),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffe8a0bf),
                            textStyle: TextStyle(color: Colors.black),
                          ),
                          child: Text(
                            S.of(context)!.buttonclickHere,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.025),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${S.of(context)!.sentenceupdateScoreHere} ',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      fontSize: size.width * 0.032,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                TextSpan(
                                  text: S.of(context)!.textButtonhere,
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: size.width * 0.032,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.red,
                                    ),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdatePatientScreen(
                                                    patientID: patientID,
                                                    renderNextButton: true)),
                                      );
                                      // Navigate to Update Patient's Info Page
                                    },
                                ),
                              ],
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffFFDEAC),
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
