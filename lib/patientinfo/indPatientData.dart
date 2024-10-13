import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/functions/MEWsCalculator.dart';
import 'package:Pulse/themes/color.dart';
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
  });

  @override
  State<PatientMewsDetail> createState() => _PatientMewsDetailState();
}

class _PatientMewsDetailState extends State<PatientMewsDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> timestampParts = widget.timestamp.split(' ');
    final Size size = MediaQuery.of(context).size;
    List<dynamic> component_value = calculateMEWS(
        context: context,
        heartRate: double.parse(widget.heart_rate),
        respiratoryRate: double.parse(widget.respiratory_rate),
        systolicBP: double.parse(widget.blood_pressure.split('/')[0]),
        temperature: double.parse(widget.temperature),
        levelOfConsciousness: widget.consciousness,
        oxygenSaturation: double.parse(widget.oxygen_saturation),
        urineOutput: double.parse(widget.urine));

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
                              "${S.of(context)!.textgender} ${getLocalizedGender(context, widget.gender)}\n"
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
                S.of(context)!.textlatestdiagnose,
                style: GoogleFonts.inter(
                  fontSize: size.width * 0.054,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.005),
              Row(
                children: [
                  Text(
                    "${S.of(context)!.date}\n${S.of(context)!.time}",
                    style: GoogleFonts.inter(
                      fontSize: size.width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Text(
                    '${timestampParts[0]}\n${timestampParts[1].split('.')[0]}',
                    style: GoogleFonts.inter(
                      fontSize: size.width * 0.065,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                          value: widget.blood_pressure.split('/')[0],
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02),
                              decoration: BoxDecoration(
                                color: forthColor,
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
            width: size.width * 0.3,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            decoration: BoxDecoration(
              color: forthColor,
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
