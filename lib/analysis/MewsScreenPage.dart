// ignore_for_file: prefer_const_constructors, deprecated_member_use, duplicate_ignore ของปลอม
//! Notification feature not implemented

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:Pulse/analysis/addPatientScreen.dart';
import 'package:Pulse/analysis/calculateMewsAndUpdateScreen.dart';
import 'package:Pulse/analysis/importPatient.dart';
import 'package:Pulse/functions/getColor.dart';
import 'package:Pulse/patientinfo/mainInfo.dart';
import 'package:Pulse/services/patient_service.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MEWsScreenPage extends StatefulWidget {
  const MEWsScreenPage({super.key});

  @override
  State<MEWsScreenPage> createState() => _MEWsScreenPageState();
}

class _MEWsScreenPageState extends State<MEWsScreenPage> {
  final PatientService patientService = PatientService();
  final uid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Column(
              children: [
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
                SizedBox(height: size.height * 0.012),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.of(context)!.descriptionMEWsFeature,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Container(
                    height: size.height * 0.5, //Does not work
                    child: StreamBuilder<List<Map<String, dynamic>>>(
                      stream: patientService.getPinhandStream(uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (snapshot.hasData) {
                          final patients = snapshot.data!;
                          if (patients.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ImportPatient(),
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.add_circle,
                                      size: 70,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    S.of(context)!.noOneIsHere,
                                    style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    S.of(context)!.clickToAddPatient,
                                    style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                    padding: EdgeInsets.only(left: 90),
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: Text.rich(
                                      TextSpan(
                                        text: S.of(context)!.textor + ' ',
                                        style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: S
                                                .of(context)!
                                                .buttonaddPatients,
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffFF0000),
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: Colors.red,
                                              ),
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddPatientScreen(),
                                                  ),
                                                );
                                              },
                                          ),
                                          TextSpan(
                                            text:
                                                '\n${S.of(context)!.toDatabase}',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: patients.length,
                                    itemBuilder: (context, index) {
                                      final patient = patients[index];

                                      String inspection_time;
                                      double inspection_time_size;
                                      Color time_color;
                                      if (patient['inspection_time'] == null) {
                                        inspection_time = '';
                                        inspection_time_size = 0;
                                        time_color = Colors.white;
                                      } else {
                                        DateTime time_data =
                                            patient['inspection_time'].toDate();

                                        inspection_time = DateFormat('HH:mm:ss')
                                            .format(time_data);
                                        inspection_time_size = 20;
                                        if (time_data.isAfter(DateTime.now())) {
                                          time_color = Colors.black;
                                        } else {
                                          time_color = Colors.red;
                                        }
                                      }
                                      return Dismissible(
                                        key: UniqueKey(),
                                        direction: DismissDirection.endToStart,
                                        background: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Container(
                                            color: Colors.red,
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.only(right: 20),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        onDismissed: (direction) {
                                          setState(() {
                                            patients.removeAt(index);
                                          });
                                          patientService.removeCareTaker(
                                              patient['id'], uid);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '${S.of(context)!.remove} ${patient['name']} ${patient['lastname']} ${S.of(context)!.fromYourCare}',
                                              ),
                                              duration:
                                                  const Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            sectionTitle(
                                                inspection_time,
                                                inspection_time_size,
                                                size,
                                                time_color),
                                            SizedBox(
                                                height: size.height * 0.013),
                                            patientInfoCard(
                                              name: patient['name'],
                                              lastname: patient['lastname'],
                                              ward: patient['ward_number'],
                                              bed_number: patient['bed_number'],
                                              size: size * 0.66,
                                              context: context,
                                              pColor:
                                                  getColor(patient['color']),
                                              patientID: patient['id'],
                                              gender: patient['gender'],
                                              hn: patient['hospital_number'],
                                            ),
                                            SizedBox(
                                                height: size.height * 0.016),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.05,
                                    vertical: size.height * 0.02,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.435,
                                        height: size.height * 0.06,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddPatientScreen(),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.02,
                                            ),
                                            backgroundColor: Color(0xffBA90CB),
                                            foregroundColor: Colors.black,
                                          ),
                                          child: Text(
                                            S.of(context)!.addNewPatient,
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.435,
                                        height: size.height * 0.06,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ImportPatient(),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.02,
                                            ),
                                            backgroundColor: Color(0xffBA90CB),
                                            foregroundColor: Colors.black,
                                          ),
                                          child: Text(
                                            S.of(context)!.importPatients,
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ImportPatient(),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.add_circle,
                                    size: 70,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  S.of(context)!.noOneIsHere,
                                  style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  S.of(context)!.clickToAddPatient,
                                  style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Container(
                                  padding: EdgeInsets.only(left: 90),
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  child: Text.rich(
                                    TextSpan(
                                      text: S.of(context)!.textor + ' ',
                                      style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              S.of(context)!.buttonaddPatients,
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffFF0000),
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: Colors.red,
                                            ),
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddPatientScreen(),
                                                ),
                                              );
                                            },
                                        ),
                                        TextSpan(
                                          text:
                                              '\n${S.of(context)!.toDatabase}',
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget sectionTitle(String title, double font_size, Size size, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: size.width * 0.05),
    child: Text(
      title,
      style: GoogleFonts.inter(
        textStyle: TextStyle(
          fontSize: font_size,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      textAlign: TextAlign.left,
    ),
  );
}

Widget patientInfoCard({
  required String name,
  required String lastname,
  required String ward,
  required String bed_number,
  required Size size,
  required BuildContext context,
  required Color pColor,
  required String patientID,
  required String gender,
  required String hn,
}) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.095),
      child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        // UpdatePatientScreen(patientID: patientID),
                        CalculateMEWsAndUpdateScreen(
                            name: name,
                            surname: lastname,
                            gender: gender,
                            hn: int.parse(hn),
                            bedNum: int.parse(bed_number),
                            ward: ward,
                            patientID: patientID)));
          },
          child: SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 4.7,
              color: pColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height * 0.006,
                ),
                leading: Padding(
                  padding: EdgeInsets.only(
                    right: size.width * 0.02,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.userNurse,
                    size: size.width * 0.14,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  '$name $lastname',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.0095),
                  child: Text(
                    '${S.of(context)!.textBedNum} $bed_number\n${S.of(context)!.textward} $ward',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: size.width * 0.047,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainInfo(
                                patientID: patientID,
                              )),
                    );
                  },
                  child: Text(
                    S.of(context)!.buttondetails,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                      vertical: size.height * 0.01,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          )));
}
