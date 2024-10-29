import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03, vertical: size.height * 0.02),
          child: Column(
            children: [
              Header(size, false),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(FontAwesomeIcons.backward),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context); // Same action as the IconButton
                    },
                    child: Text(
                      S.of(context)!.back,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.015),
              Container(
                margin: EdgeInsets.all(size.width * 0.03),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.05),
                  color: const Color(0xffFFDDEC),
                ),
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidCircleQuestion,
                            size: size.height * 0.04,
                            color: Colors.pinkAccent,
                          ),
                          SizedBox(width: size.width * 0.02),
                          Text(
                            S.of(context)!.aboutSoftware,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: size.height * 0.035,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FontAwesomeIcons.userNurse,
                            size: size.height * 0.07,
                            color: Colors.pinkAccent,
                          ),
                          Icon(
                            FontAwesomeIcons.commentMedical,
                            size: size.height * 0.07,
                            color: Colors.pinkAccent,
                          ),
                          Icon(
                            FontAwesomeIcons.bed,
                            size: size.height * 0.07,
                            color: Colors.pinkAccent,
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: size.width * 0.3,
                              child: Text(
                                S.of(context)!.firstDescription,
                                style: TextStyle(
                                  fontSize: size.height * 0.028,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.12,
                            child: VerticalDivider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: size.width * 0.45,
                              child: Text(
                                S.of(context)!.secondDescription,
                                style: TextStyle(
                                  fontSize: size.height * 0.02,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.04),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.015),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  FontAwesomeIcons.stethoscope,
                                  size: size.height * 0.05,
                                  color: Colors.pinkAccent,
                                ),
                                Icon(
                                  FontAwesomeIcons.arrowRight,
                                  size: size.height * 0.05,
                                  color: Colors.pinkAccent,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.02,
                                    horizontal: size.width * 0.04,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: size.width * 0.015),
                                            child: Icon(
                                              FontAwesomeIcons.flask,
                                              size: size.height * 0.05,
                                              color: Colors.pinkAccent,
                                            ),
                                          ),
                                          SizedBox(width: size.width * 0.015),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.01),
                                            child: Icon(
                                              FontAwesomeIcons.lungs,
                                              size: size.height * 0.05,
                                              color: Colors.pinkAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: size.height * 0.02),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.heartPulse,
                                            size: size.height * 0.05,
                                            color: Colors.pinkAccent,
                                          ),
                                          SizedBox(width: size.width * 0.03),
                                          Icon(
                                            FontAwesomeIcons.brain,
                                            size: size.height * 0.05,
                                            color: Colors.pinkAccent,
                                          ),
                                        ],
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width * 0.3,
                            child: Text(
                              "MEWS Score",
                              style: TextStyle(
                                fontSize: size.height * 0.024,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.095,
                            child: VerticalDivider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          ),
                          Container(
                            width: size.width * 0.45,
                            height: size.height * 0.1,
                            child: Text(
                              S.of(context)!.forthDescription,
                              style: TextStyle(
                                fontSize: size.height * 0.02,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
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
