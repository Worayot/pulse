import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Pulse/analysis/updatePatientScreen.dart';
import 'package:Pulse/screens/HomeScreen.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:Pulse/treatmentsOnly/HighResult.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HighPage extends StatelessWidget {
  final int MEWs;

  const HighPage({
    super.key,
    required this.MEWs,
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
            SizedBox(height: size.height * 0.04),
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
                                    HighResultPage(MEWs: MEWs),
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
