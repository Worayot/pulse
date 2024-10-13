import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Pulse/analysis/updatePatientScreen.dart';
import 'package:Pulse/screens/homeScreen.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:Pulse/treatments/HighResult.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HighPage extends StatelessWidget {
  final int MEWs;
  final String patientID;

  const HighPage({
    super.key,
    required this.MEWs,
    required this.patientID,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xffFFDDEC),
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
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            width: size.width * 0.25,
                            height: size.width * 0.25,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset(
                                'assets/images/rainy-cloud.png', // Replace with your image path
                              ),
                            ),
                          ),
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
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            width: size.width * 0.25,
                            height: size.width * 0.25,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset(
                                'assets/images/thunder-cloud.png', // Replace with your image path
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  FaIcon(
                    FontAwesomeIcons.solidFaceSadCry,
                    size: size.width * 0.26,
                    color: const Color(0xffeb5500),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    S.of(context)!.resulthigh,
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
                                  builder: (context) => HighResultPage(
                                        MEWs: MEWs,
                                        patientID: patientID,
                                      )),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffe8a0bf),
                            textStyle: const TextStyle(color: Colors.black),
                          ),
                          child: Text(
                            S.of(context)!.buttonclickHere,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
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
                                                  renderNextButton: true,
                                                )),
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
                          backgroundColor: const Color(0xffFFDEAC),
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
