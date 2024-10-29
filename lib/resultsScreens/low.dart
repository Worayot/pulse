import 'package:Pulse/themes/components/ManagementWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Pulse/treatments/lowResult.dart';
import 'package:Pulse/screens/HomeScreen.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LowPage extends StatefulWidget {
  final int MEWs;
  final String patientID;

  const LowPage({
    super.key,
    required this.MEWs,
    required this.patientID,
  });

  @override
  _LowPageState createState() => _LowPageState();
}

class _LowPageState extends State<LowPage> {
  bool isManagementView = false;
  String management = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
                                  width: size.width * 0.3,
                                  height: size.width * 0.3,
                                  child: Image.asset(
                                    'assets/images/sun-cloud.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  widget.MEWs.toString(),
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
                                  width: size.width * 0.3,
                                  height: size.width * 0.3,
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
                          SizedBox(height: size.height * 0.035),
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
                                        builder: (context) => LowResultPage(
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
                                          horizontal: 5),
                                      child: Text(
                                        S.of(context)!.buttonbackToHome,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
      ),
    );
  }
}
