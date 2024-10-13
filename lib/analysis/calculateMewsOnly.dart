// ignore_for_file: avoid_print
// Main class for the calculating MEWs page
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/resultsScreensOnly/high.dart';
import 'package:Pulse/resultsScreensOnly/low.dart';
import 'package:Pulse/resultsScreensOnly/lowMedium.dart';
import 'package:Pulse/resultsScreensOnly/medium.dart';
import 'package:Pulse/resultsScreensOnly/mediumHigh.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:Pulse/functions/MEWsCalculator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalculateMEWsOnly extends StatefulWidget {
  const CalculateMEWsOnly({super.key});

  @override
  _CalculateMEWsOnlyState createState() => _CalculateMEWsOnlyState();
}

class _CalculateMEWsOnlyState extends State<CalculateMEWsOnly> {
  final TextEditingController _pulseController = TextEditingController();
  final TextEditingController _spo2Controller = TextEditingController();
  final TextEditingController _tempController = TextEditingController();
  final TextEditingController _rrController = TextEditingController();
  final TextEditingController _urineController = TextEditingController();
  final TextEditingController _sysBpController = TextEditingController();
  final TextEditingController _diasBpController = TextEditingController();

  String? _consciousValue;

  @override
  void dispose() {
    _pulseController.dispose();
    _spo2Controller.dispose();
    _tempController.dispose();
    _sysBpController.dispose();
    _rrController.dispose();
    _diasBpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String description = S.of(context)!.textinputNum;

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
                          icon: FontAwesomeIcons.thermometerHalf,
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
                        _buildPatientSection(description),
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
                          title: 'SpO2',
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
                      onPressed: () {
                        final double heartRate =
                            double.tryParse(_pulseController.text) ?? 0.0;
                        final double respiratoryRate =
                            double.tryParse(_rrController.text) ?? 0.0;
                        final double systolicBP =
                            double.tryParse(_sysBpController.text) ?? 0.0;
                        // final double diastolicBP =
                        //     double.tryParse(_diasBpController.text) ?? 0.0;
                        final double temperature =
                            double.tryParse(_tempController.text) ?? 0.0;
                        final double oxygenSaturation =
                            double.tryParse(_spo2Controller.text) ?? 0.0;
                        final double urineOutput =
                            double.tryParse(_urineController.text) ?? 0.0;
                        final String levelOfConsciousness =
                            _consciousValue ?? 'C'; // Default to 'C' if null

                        // Add these values to the database

                        int MEWs = calculateMEWS(
                          context: context,
                          heartRate: heartRate,
                          respiratoryRate: respiratoryRate,
                          systolicBP: systolicBP,
                          temperature: temperature,
                          levelOfConsciousness: levelOfConsciousness,
                          oxygenSaturation: oxygenSaturation,
                          urineOutput: urineOutput,
                        ).last.toInt();

                        if (MEWs <= 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LowPage(MEWs: MEWs)),
                          );
                        } else if (MEWs > 1 && MEWs <= 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LowMediumPage(MEWs: MEWs)),
                          );
                        } else if (MEWs > 2 && MEWs <= 3) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MediumPage(MEWs: MEWs)),
                          );
                        } else if ((MEWs > 3 && MEWs <= 4)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MediumHighPage(MEWs: MEWs)),
                          );
                        } else if (MEWs > 4) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HighPage(MEWs: MEWs)),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HighPage(MEWs: MEWs)),
                          );
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
                    ),
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
        // FaIcon(icon, size: 40, color: color),
        Text(title),
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
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
              hintText: '0',
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
        Text(title, textAlign: TextAlign.center),
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
              child: Text(S.of(context)!.conscious),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPatientSection(String description) {
    return Column(
      children: [
        const FaIcon(
          FontAwesomeIcons.solidUser,
          size: 70,
          color: Color.fromARGB(255, 51, 221, 158),
        ),
        const Text(
          '<patient>', // This can be a constant string if needed
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 5),
        Text(
          description, // This is a runtime value
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
              FaIcon(icon, size: 40, color: Colors.red)
            ])),
        Text(title),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xffFFDDEC),
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: sysController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
                hintText: '0',
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
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
                hintText: '0',
              ),
            ),
          ),
        ])
      ],
    );
  }
}
