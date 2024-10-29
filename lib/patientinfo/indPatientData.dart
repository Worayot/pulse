import 'package:Pulse/services/mews_service.dart';
import 'package:Pulse/themes/components/ManagementWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/functions/MEWsCalculator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/functions/getLocoalizedString.dart';

class PatientMewsDetail extends StatefulWidget {
  final String name;
  final String lastName;
  final String gender;
  final String bedNumber;
  final String hospitalNumber;
  final String wardNumber;
  final String blood_pressure;
  final String consciousness;
  final String heart_rate;
  final String temperature;
  final String oxygen_saturation;
  final String respiratory_rate;
  final String urine;
  final String mews_score;
  final String timestamp;
  final String patientID;

  const PatientMewsDetail({
    super.key,
    required this.name,
    required this.lastName,
    required this.gender,
    required this.bedNumber,
    required this.hospitalNumber,
    required this.wardNumber,
    required this.blood_pressure,
    required this.consciousness,
    required this.heart_rate,
    required this.temperature,
    required this.oxygen_saturation,
    required this.respiratory_rate,
    required this.urine,
    required this.mews_score,
    required this.timestamp,
    required this.patientID,
  });

  @override
  State<PatientMewsDetail> createState() => _PatientMewsDetailState();
}

class _PatientMewsDetailState extends State<PatientMewsDetail> {
  String? latestNote;
  final TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  final uid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  void initState() {
    super.initState();
    fetchLatestNote();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  MewsService mewsService = MewsService();

  // Method to fetch the latest note
  void fetchLatestNote() async {
    MewsService mewsService = MewsService();
    String? note = await mewsService.getLatestNoteByPatientId(widget.patientID);

    setState(() {
      latestNote = note; // Update the state with the latest note
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> timestampParts = widget.timestamp.split(' ');
    final Size size = MediaQuery.of(context).size;
    List<dynamic> component_value = calculateMEWS(
        context: context,
        heartRateString: widget.heart_rate,
        respiratoryRateString: widget.respiratory_rate,
        systolicBPString: (widget.blood_pressure.split('/')[0]),
        temperatureString: widget.temperature,
        levelOfConsciousness: widget.consciousness,
        oxygenSaturationString: widget.oxygen_saturation,
        urineOutputString: widget.urine);
    Map<String, String> genderMap = {
      'Male': S.of(context)!.male,
      'Female': S.of(context)!.female,
      'None': S.of(context)!.none,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height * 0.002),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffFFDDEC),
            borderRadius: BorderRadius.circular(size.width * 0.05),
          ),
          padding: EdgeInsets.all(size.width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidUser,
                    size: size.width * 0.1,
                    color: const Color.fromARGB(255, 161, 161, 161),
                  ),
                  SizedBox(width: size.width * 0.05),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.name} ${widget.lastName}',
                          style: GoogleFonts.inter(
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${S.of(context)!.textgender} ${genderMap[widget.gender]}\n"
                              "${S.of(context)!.texthn} ${widget.hospitalNumber}\n"
                              "${S.of(context)!.textBedNum} ${widget.bedNumber}",
                              style: GoogleFonts.inter(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.023),
              Text(
                S.of(context)!.textlatestdiagnose + ":",
                style: GoogleFonts.inter(
                  fontSize: size.width * 0.054,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.005),
              Row(
                children: [
                  Text(
                    '${timestampParts[0]} ${timestampParts[1].split('.')[0]}',
                    style: GoogleFonts.inter(
                      fontSize: size.width * 0.065,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.01),
              Row(
                children: [
                  Text(
                    S.of(context)!.note,
                    style: GoogleFonts.inter(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  FaIcon(
                    FontAwesomeIcons.penToSquare,
                    color: Colors.black,
                    size: size.width * 0.04,
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.01),
              // Management editor
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: _focusNode.hasFocus ? null : double.infinity,
                      height: size.height * 0.15,
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: latestNote,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_focusNode.hasFocus)
                    SizedBox(width: 8), // Add some spacing
                  if (_focusNode.hasFocus)
                    Column(children: [
                      ElevatedButton(
                        onPressed: () async {
                          _focusNode.unfocus();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize:
                              Size(size.width * 0.15, size.height * 0.06),
                        ),
                        child: Text(
                          S.of(context)!.cancel,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_controller.text.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(S.of(context)!.noteSaved),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.green,
                              ),
                            );

                            await MewsService.addMEWsToPatientAndNote(
                              blood_pressure: widget.blood_pressure,
                              consciousness: widget.consciousness,
                              heart_rate: widget.heart_rate,
                              mews_score: widget.mews_score,
                              oxygen_saturation: widget.oxygen_saturation,
                              temperature: widget.temperature,
                              urine: widget.urine,
                              respiratory_rate: widget.respiratory_rate,
                              uid: uid,
                              patient_id: widget.patientID,
                              note: _controller.text,
                            );

                            _controller.clear();
                            fetchLatestNote();
                            _focusNode.unfocus();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(S.of(context)!.pleaseFillNote),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffBA90CB),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize:
                              Size(size.width * 0.15, size.height * 0.06),
                        ),
                        child: Text(
                          S.of(context)!.save,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ])
                ],
              ),

              SizedBox(height: size.height * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context)!.texttotalMEWs,
                    style: GoogleFonts.inter(
                      fontSize: size.width * 0.052,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Text(
                    widget.mews_score.toString().split('.')[0],
                    style: GoogleFonts.inter(
                      fontSize: size.width * 0.067,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      _buildMewDetail(
                          iconData: FontAwesomeIcons.heartPulse,
                          value: widget.heart_rate.toString(),
                          unit: "BPM",
                          size: size,
                          color: const Color(0xffFF006E),
                          component_value: component_value[0]),
                      _buildMewDetail(
                          iconData: FontAwesomeIcons.maskVentilator,
                          value: widget.oxygen_saturation.toString(),
                          unit: "%",
                          size: size,
                          color: const Color(0xff6d6d6d),
                          component_value: component_value[5]),
                      _buildMewDetail(
                          iconData: FontAwesomeIcons.droplet,
                          value: widget.blood_pressure.split('/')[0] +
                              '/' +
                              widget.blood_pressure.split('/')[1],
                          unit: "mmHg",
                          size: size,
                          color: const Color(0xffFF0000),
                          component_value: component_value[2]),
                      _buildMewDetail(
                          iconData: FontAwesomeIcons.lungs,
                          value: widget.respiratory_rate.toString(),
                          unit: "BPM",
                          size: size,
                          color: const Color(0xff7569FF),
                          component_value: component_value[1]),
                      _buildMewDetail(
                          iconData: FontAwesomeIcons.temperatureThreeQuarters,
                          value: widget.temperature.toString(),
                          unit: "°C",
                          size: size,
                          color: const Color(0xff7AC5EE),
                          component_value: component_value[3]),
                      _buildMewDetail(
                          iconData: FontAwesomeIcons.flask,
                          value: widget.urine.toString(),
                          unit: "mmHg",
                          size: size,
                          color: const Color(0xffFFB84E),
                          component_value: component_value[6]),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.005),
                        child: Row(
                          children: [
                            Container(
                              width: size.width * 0.09,
                              child: FaIcon(
                                FontAwesomeIcons.brain,
                                color: const Color(0xffFFA1CA),
                                size: size.width * 0.06,
                              ),
                            ),
                            SizedBox(width: size.width * 0.02),
                            Container(
                              width: size.width * 0.35,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              decoration: BoxDecoration(
                                color: Color(0xffffffffff),
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.03),
                              ),
                              child: Text(
                                getLocalizedConsciousValue(
                                    context, widget.consciousness),
                                style: GoogleFonts.inter(
                                  fontSize: size.width * 0.04,
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.02),
                            Text(
                              ': ${component_value[4]}',
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildMewDetail({
    required IconData iconData,
    required String value,
    required String unit,
    required Size size,
    required Color color,
    required int component_value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.width * 0.01),
      child: Row(
        children: [
          Container(
            width: size.width * 0.09,
            child: FaIcon(
              iconData,
              color: color,
              size: size.width * 0.06,
            ),
          ),
          SizedBox(width: size.width * 0.02),
          Container(
            width: size.width * 0.35,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            decoration: BoxDecoration(
              color: Color(0xffffffffff),
              borderRadius: BorderRadius.circular(size.width * 0.03),
            ),
            child: Text(
              "$value $unit",
              style: GoogleFonts.inter(
                fontSize: size.width * 0.04,
              ),
            ),
          ),
          SizedBox(width: size.width * 0.02),
          Text(
            ': ${component_value}',
            style: TextStyle(
              fontSize: size.width * 0.05,
            ),
          )
        ],
      ),
    );
  }
}
