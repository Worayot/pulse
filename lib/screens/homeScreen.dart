// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Pulse/analysis/MewsScreenPage.dart';
import 'package:Pulse/analysis/addPatientScreen.dart';
import 'package:Pulse/analysis/calculateMewsOnly.dart';
import 'package:Pulse/patientinfo/patientListPage.dart';
import 'package:Pulse/screens/allFeaturesScreen.dart';
import 'package:Pulse/screens/qrScreen.dart';
import 'package:Pulse/themes/components/barcodeScanner.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:Pulse/themes/components/featurecardwithtap.dart';
import 'package:Pulse/utils/settings_loader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: loadSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading settings'));
        } else {
          final size = MediaQuery.of(context).size;

          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header section
                    Header(size, true),

                    SizedBox(height: size.height * 0.02),
                    Text(
                      S.of(context)!.homeTitle,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: [
                        Text(
                          S.of(context)!.allFeatures,
                          style: GoogleFonts.inter(fontSize: 17),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AllFeaturesScreen()),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor:
                                const Color.fromARGB(255, 126, 126, 126),
                          ),
                          child: Text(
                            S.of(context)!.searchFeatures,
                            style: GoogleFonts.inter(fontSize: 14),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    // Slider
                    Padding(
                      padding: EdgeInsets.all(size.height * 0.02),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01),
                              child: FeatureCardWithTap(
                                title: 'MEWS',
                                subtitle: S.of(context)!.descriptionMEWsFeature,
                                icon: FontAwesomeIcons.exclamationTriangle,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MEWsScreenPage()),
                                  );
                                },
                                size: size,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01),
                              child: FeatureCardWithTap(
                                title: S.of(context)!.featureNamepatients,
                                subtitle:
                                    S.of(context)!.descriptionpatientsFeature,
                                icon: FontAwesomeIcons.user,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Patientlistpage()),
                                  );
                                },
                                size: size,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01),
                              child: FeatureCardWithTap(
                                title: S.of(context)!.featureNamecalculate,
                                subtitle:
                                    S.of(context)!.descriptioncalculatorFeature,
                                icon: FontAwesomeIcons.calculator,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CalculateMEWsOnly()),
                                  );
                                },
                                size: size,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01),
                              child: FeatureCardWithTap(
                                title: S.of(context)!.addPatients,
                                subtitle: S.of(context)!.addPateintToDatabase,
                                icon: FontAwesomeIcons.plus,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddPatientScreen()),
                                  );
                                },
                                size: size,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01),
                              child: FeatureCardWithTap(
                                title: S.of(context)!.scanPatient,
                                subtitle: S.of(context)!.scanPatientBarcode,
                                icon: FontAwesomeIcons.barcode,
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => BarcodeScanner()),
                                  // );
                                },
                                size: size,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01),
                              child: FeatureCardWithTap(
                                title: S.of(context)!.swapShift,
                                subtitle:
                                    S.of(context)!.swapShiftWithOtherNurse,
                                icon: FontAwesomeIcons.arrowsRotate,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QrCodePage()),
                                  );
                                },
                                size: size,
                              ),
                            ),
                            // Add Future Features Here
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Text(
                      S.of(context)!.futureFeatures,
                      style: GoogleFonts.inter(fontSize: 17),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.solidSmileWink,
                              color: Color(0xffFFCD50), size: size.width * 0.2),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            S.of(context)!.sentenceemojiText,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: size.width * 0.04),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
