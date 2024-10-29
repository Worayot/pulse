// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/screens/HomeScreen.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:Pulse/resultsScreensOnly/high.dart';

class HighResultPage extends StatelessWidget {
  final int MEWs;
  const HighResultPage({
    super.key,
    required this.MEWs,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(size, true),
            Row(
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.arrowLeft,
                      size: size.width * 0.06),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HighPage(MEWs: MEWs),
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
            SizedBox(height: size.height * 0.001),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                S.of(context)!.descriptionscoreUpdate,
                textAlign: TextAlign.right,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: size.width * 0.029,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.005),
            Container(
              padding: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                color: const Color(0xffFFDDEC),
                borderRadius: BorderRadius.circular(size.width * 0.04),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(FontAwesomeIcons.solidCircleCheck,
                          size: size.width * 0.1),
                      SizedBox(width: size.width * 0.05),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.035,
                            vertical: size.height * 0.01),
                        decoration: BoxDecoration(
                          color: const Color(0xffe8a0bf),
                          borderRadius:
                              BorderRadius.circular(size.width * 0.02),
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
                  SizedBox(height: size.height * 0.028),
                  Text(
                    S.of(context)!.nursinghigh,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: size.height * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: size.width * 0.02), // Adjust spacing
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFFDEAC),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
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
