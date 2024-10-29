// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_declarations

import 'package:Pulse/screens/export.dart';
import 'package:flutter/material.dart';
import 'package:Pulse/analysis/MewsScreenPage.dart';
import 'package:Pulse/analysis/addPatientScreen.dart';
import 'package:Pulse/analysis/calculateMewsOnly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Pulse/patientinfo/patientListPage.dart';
import 'package:Pulse/screens/qrScreen.dart';
// import 'package:Pulse/themes/components/barcodeScanner.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/themes/components/featurecardwithtap.dart';
import 'package:Pulse/themes/components/searchbarwithfilter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<Map<String, dynamic>> featureCards = [
      {
        'title': 'MEWS',
        'subtitle': S.of(context)!.descriptionMEWsFeature,
        'icon': FontAwesomeIcons.exclamationTriangle,
        'onTap': () {
          // Navigate to MEWSUpdatePage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MEWsScreenPage()),
          );
        },
      },
      {
        'title': S.of(context)!.featureNamepatients,
        'subtitle': S.of(context)!.patientDatabase,
        'icon': FontAwesomeIcons.user,
        'onTap': () {
          // Navigate to PatientCRUDPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Patientlistpage()),
          );
        },
      },
      {
        'title': S.of(context)!.featureNamecalculate,
        'subtitle': S.of(context)!.descriptioncalculatorFeature,
        'icon': FontAwesomeIcons.calculator,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CalculateMEWsOnly()),
          );
        },
      },
      {
        'title': S.of(context)!.buttonaddPatients,
        'subtitle': S.of(context)!.addPateintToDatabase,
        'icon': FontAwesomeIcons.plus,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPatientScreen()),
          );
        },
      },
      {
        'title': S.of(context)!.document,
        'subtitle': S.of(context)!.exportPatientDocument,
        'icon': FontAwesomeIcons.fileExport,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExportPage()),
          );
        },
      },
      {
        'title': S.of(context)!.swapShift,
        'subtitle': S.of(context)!.swapShiftWithOtherNurse,
        'icon': FontAwesomeIcons.arrowsRotate,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QrCodePage()),
          );
        },
      },
    ];

    // Filter the feature cards based on the search query
    final filteredFeatureCards = featureCards.where((card) {
      final titleLower = card['title'].toString().toLowerCase();
      final queryLower = searchQuery.toLowerCase();
      return titleLower.contains(queryLower);
    }).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(size, true),
              FilteringSearchBar(
                size: size,
                onSearchChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              SizedBox(height: size.height * 0.025),
              // Wrap GridView.builder in a SizedBox
              SizedBox(
                height: size.height,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.95,
                    mainAxisSpacing: size.height * 0.02,
                    crossAxisSpacing: size.width * 0.04,
                  ),
                  itemCount: filteredFeatureCards.length,
                  itemBuilder: (context, index) {
                    final card = filteredFeatureCards[index];
                    return FeatureCardWithTap(
                      title: card['title'],
                      subtitle: card['subtitle'],
                      icon: card['icon'],
                      onTap: card['onTap'],
                      size: size,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
