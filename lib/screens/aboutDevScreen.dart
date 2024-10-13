import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class aboutDev extends StatelessWidget {
  const aboutDev({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.03),
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
                  Text(
                    S.of(context)!.back,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.005),
              IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.05),
                      color: const Color(0xffFFDDEC),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(size.width * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title Section with Headphone Icon
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.headphonesSimple,
                                    size: size.height * 0.04,
                                    color: Colors.pinkAccent,
                                  ),
                                  SizedBox(width: size.width * 0.02),
                                  Text(
                                    S.of(context)!.aboutDev,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      fontSize: size.height * 0.035,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: size.height * 0.02),

                              // About Dev Description with Book Icon
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.book,
                                    size: size.height * 0.03,
                                    color: Colors.pinkAccent,
                                  ),
                                  SizedBox(width: size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      S.of(context)!.aboutDevDescription,
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.inter(
                                        fontSize: size.height * 0.025,
                                        color:
                                            const Color.fromARGB(213, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: size.height * 0.02),

                              // Developer Names with User Icon
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.user,
                                    size: size.height * 0.03,
                                    color: Colors.pinkAccent,
                                  ),
                                  SizedBox(width: size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      S.of(context)!.devNames,
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.inter(
                                        fontSize: size.height * 0.025,
                                        color:
                                            const Color.fromARGB(213, 0, 0, 0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: size.height * 0.03),

                              // Contact Information with Envelope Icon
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.envelope,
                                    size: size.height * 0.03,
                                    color: Colors.pinkAccent,
                                  ),
                                  SizedBox(width: size.width * 0.02),
                                  Expanded(
                                    child: Text(
                                      S.of(context)!.contactDevAt,
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.inter(
                                        fontSize: size.height * 0.025,
                                        color:
                                            const Color.fromARGB(213, 0, 0, 0),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
