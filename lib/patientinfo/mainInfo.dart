import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/patientinfo/indPatientData.dart';
import 'package:Pulse/patientinfo/mewsFullReport.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/services/mews_service.dart';
import 'package:Pulse/services/patient_service.dart';
import 'package:Pulse/themes/components/header.dart';

class MainInfo extends StatefulWidget {
  final String patientID;
  const MainInfo({Key? key, required this.patientID}) : super(key: key);

  @override
  State<MainInfo> createState() => _MainInfoState();
}

class _MainInfoState extends State<MainInfo> {
  bool _isFirstVisible = false;
  bool _isForthVisible = false;

  late Stream<List<Map<String, dynamic>>> patientMEWsData;

  Map<String, dynamic>? _patientData;

  Map<String, dynamic>? patientMEWsDetails = {
    'blood_pressure': '0/0',
    'consciousness': '',
    'heart_rate': 0,
    'temperature': 0,
    'oxygen_saturation': 0,
    'respiratory_rate': 0,
    'urine': 0,
    'mews_score': 0,
    'patient_id': '',
    'timestamp': '',
  };

  Future<void> fetchPatientDetails() async {
    try {
      Map<String, dynamic> patientData =
          await PatientService().getPatientById(widget.patientID);
      setState(() {
        _patientData = patientData;
      });
    } catch (e) {
      print('Error fetching patient details: $e');
    }
  }

  Future<void> fetchMEWsData() async {
    try {
      final mewsStream = MewsService().getMewsStream2(widget.patientID);

      mewsStream.listen((MEWsData) {
        DateTime timestamp;
        if (MEWsData['timestamp'] is Timestamp) {
          timestamp = (MEWsData['timestamp'] as Timestamp).toDate();
        } else if (MEWsData['timestamp'] is String) {
          timestamp = DateTime.parse(MEWsData['timestamp']);
        } else {
          timestamp = DateTime.now();
        }

        setState(() {
          patientMEWsDetails = {
            'blood_pressure': MEWsData['blood_pressure']?.toString() ?? '0/0',
            'consciousness': MEWsData['consciousness']?.toString() ?? '',
            'heart_rate': MEWsData['heart_rate']?.toString() ?? '',
            'temperature': MEWsData['temperature']?.toString() ?? '',
            'oxygen_saturation':
                MEWsData['oxygen_saturation']?.toString() ?? '',
            'respiratory_rate': MEWsData['respiratory_rate']?.toString() ?? '',
            'urine': MEWsData['urine']?.toString() ?? '',
            'mews_score': MEWsData['mews_score']?.toString() ?? '',
            'patient_id': MEWsData['patient_id'] ?? '',
            'timestamp': timestamp.toString(),
          };
        });
      }).onError((e) {
        print('Failed to fetch MEWs data: $e');
      });
    } catch (e) {
      print('Failed to fetch MEWs data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMEWsData();
    fetchPatientDetails();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.03),
          child: Column(
            children: [
              Header(size, true),
              // SizedBox(height: size.height * 0.027),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(FontAwesomeIcons.backward),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(
                              context); // Same action as the IconButton
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
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isFirstVisible = !_isFirstVisible;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.015,
                      vertical: size.width * 0.01),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.width * 0.01),
                  decoration: BoxDecoration(
                      color: Color(0xffFFDDEC),
                      borderRadius: BorderRadius.circular(size.width * 0.03)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            S.of(context)!.patientData,
                            style: GoogleFonts.inter(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 5),
                          _isFirstVisible
                              ? FaIcon(FontAwesomeIcons.caretDown,
                                  size: size.width * 0.07)
                              : FaIcon(FontAwesomeIcons.caretRight,
                                  size: size.width * 0.07)
                        ],
                      ),
                      Visibility(
                        visible: _isFirstVisible,
                        child: Column(
                          children: [
                            SizedBox(height: size.height * 0.02),
                            patientMEWsDetails!['respiratory_rate'] == ''
                                ? Center(
                                    child: Text(S.of(context)!.noDataAvail))
                                : PatientMewsDetail(
                                    name: _patientData?['name'] ?? 'N/A',
                                    lastName:
                                        _patientData?['lastname'] ?? 'N/A',
                                    gender: _patientData?['gender'] ?? 'N/A',
                                    bedNumber: _patientData?['bed_number']
                                            ?.toString() ??
                                        'N/A',
                                    hospitalNumber:
                                        _patientData?['hospital_number']
                                                ?.toString() ??
                                            'N/A',
                                    wardNumber:
                                        _patientData?['ward_number'] ?? 'N/A',
                                    blood_pressure:
                                        patientMEWsDetails?['blood_pressure'] ??
                                            '0/0',
                                    consciousness:
                                        patientMEWsDetails?['consciousness']
                                                ?.toString() ??
                                            'N/A',
                                    heart_rate:
                                        patientMEWsDetails?['heart_rate']
                                                ?.toString() ??
                                            'N/A',
                                    temperature:
                                        patientMEWsDetails?['temperature']
                                                ?.toString() ??
                                            'N/A',
                                    oxygen_saturation:
                                        patientMEWsDetails?['oxygen_saturation']
                                                ?.toString() ??
                                            'N/A',
                                    respiratory_rate:
                                        patientMEWsDetails?['respiratory_rate']
                                                ?.toString() ??
                                            'N/A',
                                    urine: patientMEWsDetails?['urine']
                                            ?.toString() ??
                                        'N/A',
                                    mews_score:
                                        patientMEWsDetails?['mews_score']
                                                ?.toString() ??
                                            'N/A',
                                    timestamp: patientMEWsDetails?['timestamp']
                                            ?.toString() ??
                                        'N/A',
                                    patientID: widget.patientID,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isForthVisible = !_isForthVisible;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.015,
                      vertical: size.width * 0.01),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.width * 0.01),
                  decoration: BoxDecoration(
                      color: Color(0xffFFDDEC),
                      borderRadius: BorderRadius.circular(size.width * 0.03)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            S.of(context)!.fullReport,
                            style: GoogleFonts.inter(
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 5),
                          _isForthVisible
                              ? FaIcon(FontAwesomeIcons.caretDown,
                                  size: size.width * 0.07)
                              : FaIcon(FontAwesomeIcons.caretRight,
                                  size: size.width * 0.07)
                        ],
                      ),
                      Visibility(
                        visible: _isForthVisible,
                        child: Column(
                          children: [
                            SizedBox(height: size.height * 0.02),
                            FullReport(
                              patientID: widget.patientID,
                            ),
                          ],
                        ),
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
