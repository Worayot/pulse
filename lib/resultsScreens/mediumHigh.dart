// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Pulse/screens/HomeScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:Pulse/treatments/MedHighResult.dart';

import '../themes/components/ManagementWidget.dart';

class MediumHighPage extends StatefulWidget {
  final int MEWs;
  final String patientID;
  const MediumHighPage(
      {super.key, required this.MEWs, required this.patientID});

  @override
  _MediumHighPageState createState() => _MediumHighPageState();
}

class _MediumHighPageState extends State<MediumHighPage> {
  bool isManagementView = false;
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
                color: Color(0xffFFDDEC),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Column(
                children: [
                  if (isManagementView)
                    ManagementWidget(
                      patientID: widget.patientID,
                    )
                  else
                    Column(
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
                              widget.MEWs
                                  .toString(), // This should be changeable based on the calculation.
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
                        SizedBox(height: size.height * 0.02),
                        Center(
                          child: Column(
                            children: [
                              // Text(
                              //   S.of(context)!.textnursing,
                              //   style: GoogleFonts.inter(
                              //     textStyle: TextStyle(
                              //       fontSize: size.width * 0.05,
                              //       fontWeight: FontWeight.normal,
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: size.height * 0.01),
                              // ElevatedButton(
                              //   onPressed: () {
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => MediumHighResultPage(
                              //                 MEWs: MEWs,
                              //                 patientID: patientID,
                              //               )),
                              //     );
                              //   },
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: Color(0xffe8a0bf),
                              //     textStyle: TextStyle(color: Colors.black),
                              //   ),
                              //   child: Text(
                              //     S.of(context)!.textnursing,
                              //     style: TextStyle(
                              //       color: Colors.black,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
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
                                          MediumHighResultPage(
                                              MEWs: widget.MEWs,
                                              patientID: widget.patientID),
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
                            // Expanded(
                            //   child: Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: Text.rich(
                            //       TextSpan(
                            //         children: [
                            //           TextSpan(
                            //             text:
                            //                 '${S.of(context)!.sentenceupdateScoreHere} ',
                            //             style: GoogleFonts.inter(
                            //               textStyle: TextStyle(
                            //                 fontSize: size.width * 0.032,
                            //                 fontWeight: FontWeight.normal,
                            //               ),
                            //             ),
                            //           ),
                            //           TextSpan(
                            //             text: S.of(context)!.textButtonhere,
                            //             style: GoogleFonts.inter(
                            //               textStyle: TextStyle(
                            //                 color: Colors.red,
                            //                 fontSize: size.width * 0.032,
                            //                 fontWeight: FontWeight.normal,
                            //                 decoration: TextDecoration.underline,
                            //                 decorationColor: Colors.red,
                            //               ),
                            //             ),
                            //             recognizer: TapGestureRecognizer()
                            //               ..onTap = () {
                            //                 Navigator.push(
                            //                   context,
                            //                   MaterialPageRoute(
                            //                       builder: (context) =>
                            //                           UpdatePatientScreen(
                            //                               patientID: patientID,
                            //                               renderNextButton: true)),
                            //                 );
                            //                 // Navigate to Update Patient's Info Page
                            //               },
                            //           ),
                            //         ],
                            //       ),
                            //       textAlign: TextAlign.left,
                            //     ),
                            //   ),
                            // ),
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
                                        builder: (context) =>
                                            const HomeScreen()),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            5), // Adjust this for the indent
                                    child: Text(
                                      S.of(context)!.buttonbackToHome,
                                      textAlign: TextAlign
                                          .center, // Text is centered inside the padding
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isManagementView = !isManagementView;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFFA3CA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                    ),
                  ),
                ),
                child: Text(
                  isManagementView
                      ? S.of(context)!.back
                      : S.of(context)!.addManagement,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
