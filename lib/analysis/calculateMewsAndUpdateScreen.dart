// ignore_for_file: avoid_print
// Main class for the calculating MEWs page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/functions/getInspectionTime.dart';
import 'package:Pulse/resultsScreens/high.dart';
import 'package:Pulse/resultsScreens/low.dart';
import 'package:Pulse/resultsScreens/lowMedium.dart';
import 'package:Pulse/resultsScreens/medium.dart';
import 'package:Pulse/resultsScreens/mediumHigh.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:Pulse/functions/MEWsCalculator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/services/patient_service.dart';
import 'package:Pulse/services/mews_service.dart';
import 'package:Pulse/functions/getLocoalizedString.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalculateMEWsAndUpdateScreen extends StatefulWidget {
  final String name;
  final String surname;
  final String gender;
  final int hn;
  final int bedNum;
  final String ward;
  final String patientID;

  // final PatientService _patientService = PatientService();

  CalculateMEWsAndUpdateScreen(
      {super.key,
      required this.name,
      required this.surname,
      required this.gender,
      required this.hn,
      required this.bedNum,
      required this.ward,
      required this.patientID});

  @override
  _CalculateMEWsAndUpdateScreenState createState() =>
      _CalculateMEWsAndUpdateScreenState();
}

class _CalculateMEWsAndUpdateScreenState
    extends State<CalculateMEWsAndUpdateScreen> {
  final TextEditingController _pulseController = TextEditingController();
  final TextEditingController _spo2Controller = TextEditingController();
  final TextEditingController _tempController = TextEditingController();
  final TextEditingController _rrController = TextEditingController();
  final TextEditingController _urineController = TextEditingController();
  final TextEditingController _sysBpController = TextEditingController();
  final TextEditingController _diasBpController = TextEditingController();

  final PatientService _patientService = PatientService();

  String? _consciousValue;

  @override
  void dispose() {
    _pulseController.dispose();
    _spo2Controller.dispose();
    _tempController.dispose();
    _sysBpController.dispose();
    _rrController.dispose();
    _diasBpController.dispose();
    _urineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String description = S.of(context)!.textinputNum;
    final uid = FirebaseAuth.instance.currentUser!.uid.toString();

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Header(size, true),
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
                    Navigator.pop(context);
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
            SizedBox(
              width: size.width,
              height: size.height,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Conscious section
                        _buildDropdownSection(
                          order: '1.',
                          icon: FontAwesomeIcons.brain,
                          title: 'Conscious',
                          value: _consciousValue,
                          items: [
                            S.of(context)!.none,
                            S.of(context)!.conscious,
                            S.of(context)!.alert,
                            S.of(context)!.verbalStimuli,
                            S.of(context)!.pain,
                            S.of(context)!.unresponsive
                          ],
                          onChanged: (value) {
                            setState(() {
                              _consciousValue = value;
                            });
                          },
                          color: const Color(0xffffa1ca),
                        ),
                        // Temp section
                        _buildInputSection(
                          order: '2.',
                          icon: FontAwesomeIcons.temperatureHalf,
                          title: 'Temp (°C)',
                          controller: _tempController,
                          color: const Color(0xff7AC5EE),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Pulse/HR section
                        _buildInputSection(
                          order: '3.',
                          icon: FontAwesomeIcons.heartbeat,
                          title: 'Pulse (HR)',
                          controller: _pulseController,
                          color: const Color(0xffff006e),
                        ),
                        // Pateint section
                        _buildPatientSection(description, widget.name),
                        // RR section
                        _buildInputSection(
                          order: '4.',
                          icon: FontAwesomeIcons.lungs,
                          title: 'RR',
                          controller: _rrController,
                          color: const Color(0xff7569FF),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // BP section
                        _buildBpSection(
                            order: '5.',
                            icon: FontAwesomeIcons.tint,
                            title: 'SBP/DBP',
                            sysController: _sysBpController,
                            diasController: _diasBpController),
                        // SpO2 section
                        _buildInputSection(
                          order: '6.',
                          icon: FontAwesomeIcons.maskVentilator,
                          title: 'SpO2\n' + S.of(context)!.whileGivingOxygen,
                          controller: _spo2Controller,
                          color: const Color(0xff6D6D6D),
                        ),
                        // Urine section
                        _buildInputSection(
                          order: '7.',
                          icon: FontAwesomeIcons.vial,
                          title: 'Urine (2 hrs up)',
                          controller: _urineController,
                          color: const Color(0xffffb84e),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () async {
                        final int? heartRate =
                            int.tryParse(_pulseController.text) ?? null;
                        final int? respiratoryRate =
                            int.tryParse(_rrController.text) ?? null;
                        final int? systolicBP =
                            int.tryParse(_sysBpController.text) ?? null;
                        final int? diastolicBP =
                            int.tryParse(_diasBpController.text) ?? null;
                        final double? temperature =
                            double.tryParse(_tempController.text) ?? null;
                        final int? oxygenSaturation =
                            int.tryParse(_spo2Controller.text) ?? null;
                        final int? urineOutput =
                            int.tryParse(_urineController.text) ?? null;
                        final String levelOfConsciousness =
                            _consciousValue ?? '-';

                        String consciousnessValue = getEnglishConsciousValue(
                            context, levelOfConsciousness);

                        if (_pulseController.text.contains('.') ||
                            _rrController.text.contains('.') ||
                            _sysBpController.text.contains('.') ||
                            _diasBpController.text.contains('.') ||
                            _spo2Controller.text.contains('.') ||
                            _urineController.text.contains('.') ||
                            _tempController.text == '.') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Invalid value"),
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          int MEWs = calculateMEWS(
                            context: context,
                            heartRateString: _pulseController.text,
                            respiratoryRateString: _rrController.text,
                            systolicBPString: _sysBpController.text,
                            temperatureString: _tempController.text,
                            levelOfConsciousness: consciousnessValue,
                            oxygenSaturationString: _spo2Controller.text,
                            urineOutputString: _urineController.text,
                          ).last.toInt();

                          // Add the patient to the database after navigating
                          Future.delayed(Duration(milliseconds: 500), () async {
                            try {
                              await _patientService.updatePatientData(
                                  name: widget.name,
                                  lastname: widget.surname,
                                  gender: widget.gender,
                                  hospital_number: widget.hn.toString(),
                                  bed_number: widget.bedNum.toString(),
                                  ward_number: widget.ward,
                                  patientID: widget.patientID,
                                  inspection_time: DateTime.now());

                              String bloodPressure = formatBloodPressure(
                                  systolicBP ?? null, diastolicBP ?? null);

                              MewsService.addMEWsToPatient(
                                  blood_pressure: bloodPressure,
                                  consciousness: consciousnessValue,
                                  heart_rate: heartRate ?? null,
                                  mews_score: MEWs,
                                  oxygen_saturation: oxygenSaturation ?? null,
                                  temperature: temperature ?? null,
                                  urine: urineOutput ?? null,
                                  respiratory_rate: respiratoryRate ?? null,
                                  uid: uid,
                                  patient_id: widget.patientID);

                              Widget resultsPage;

                              if (MEWs <= 1) {
                                resultsPage = LowPage(
                                  MEWs: MEWs,
                                  patientID: widget.patientID,
                                );
                              } else if (MEWs > 1 && MEWs <= 2) {
                                resultsPage = LowMediumPage(
                                    MEWs: MEWs, patientID: widget.patientID);
                              } else if (MEWs > 2 && MEWs <= 3) {
                                resultsPage = MediumPage(
                                    MEWs: MEWs, patientID: widget.patientID);
                              } else if (MEWs > 3 && MEWs <= 4) {
                                resultsPage = MediumHighPage(
                                    MEWs: MEWs, patientID: widget.patientID);
                              } else {
                                resultsPage = HighPage(
                                    MEWs: MEWs, patientID: widget.patientID);
                              }

                              await _patientService.updatePatientColor(
                                  color: MEWs, patientID: widget.patientID);

                              DateTime inspection_time =
                                  await getInspectionTime(
                                      widget.patientID, MEWs);

                              _patientService.setInspectionTime(
                                  widget.patientID, inspection_time);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(S.of(context)!.calSuccess),
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              // Navigate to the results page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => resultsPage),
                              );
                            } catch (error) {
                              print('Error adding patient: $error');
                            }
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFFB2B2),
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.02,
                            horizontal: size.width * 0.07),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.05),
                        ),
                      ),
                      child: Text(
                        S.of(context)!.buttoncalculate,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width * 0.05,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection({
    required String order,
    required IconData icon,
    required String title,
    required TextEditingController controller,
    required Color color,
  }) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: Row(children: [
              Text(order,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(width: 15),
              FaIcon(icon, size: 45, color: color)
            ])),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        ),
        const SizedBox(height: 10),
        Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xffFFDDEC),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
              hintText: '-',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownSection({
    required String order,
    required IconData icon,
    required String title,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required Color color,
  }) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: Row(children: [
              Text(order,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(width: 15),
              FaIcon(icon, size: 45, color: color)
            ])),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        ),
        const SizedBox(height: 10),
        Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xffFFDDEC),
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            underline: const SizedBox(),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(item),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            hint: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('-'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPatientSection(String description, String patientName) {
    return Column(
      children: [
        const FaIcon(
          FontAwesomeIcons.solidUser,
          size: 70,
          color: Color.fromARGB(255, 51, 221, 158),
        ),
        Text(
          patientName,
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 5),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildBpSection({
    required String order,
    required IconData icon,
    required String title,
    required TextEditingController sysController,
    required TextEditingController diasController,
  }) {
    // FocusNodes to manage focus between text fields
    final FocusNode sysFocusNode = FocusNode();
    final FocusNode diasFocusNode = FocusNode();

    // Adding a listener to the sysController
    sysController.addListener(() {
      if (sysController.text.length == 3) {
        // Move focus to the diastolic input field
        diasFocusNode.requestFocus();
      }
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 25.0),
          child: Row(children: [
            Text(
              order,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 15),
            FaIcon(icon, size: 40, color: Colors.red),
          ]),
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xffFFDDEC),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: sysController,
                focusNode: sysFocusNode, // Assign sysFocusNode to this field
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                  hintText: '-',
                ),
              ),
            ),
            SizedBox(width: 4),
            Text(
              '/',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 4),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xffFFDDEC),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: diasController,
                focusNode: diasFocusNode, // Assign diasFocusNode to this field
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                  hintText: '-',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
