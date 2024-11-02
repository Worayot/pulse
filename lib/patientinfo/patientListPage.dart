import 'package:Pulse/analysis/calculateMewsAndUpdateScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/analysis/updatePatientScreen.dart';
import 'package:Pulse/patientinfo/mainInfo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:Pulse/themes/components/searchbarwithfilter.dart'; // Replace this with your FilteringSearchBar import
import 'package:Pulse/services/patient_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Patientlistpage extends StatefulWidget {
  // รายชื่อผู้ป่วยในฐานข้อมูล
  const Patientlistpage({super.key});

  @override
  State<Patientlistpage> createState() => _PatientlistpageState();
}

class _PatientlistpageState extends State<Patientlistpage> {
  final PatientService patientService = PatientService();
  String _searchQuery = ''; // This is the search query state

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
              Container(
                margin: EdgeInsets.only(top: size.height * 0.015),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context)!.observerList,
                      style: GoogleFonts.inter(
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    FilteringSearchBar(
                      size: size,
                      onSearchChanged: (query) {
                        setState(() {
                          _searchQuery = query.toLowerCase();
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width * 0.05),
                  color: Color(0xffFFDDEC),
                ),
                height: size.height * 0.6,
                child: SizedBox(
                  height: 690,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: patientService.getPatientStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List patientList = snapshot.data!.docs;

                        List filteredList = patientList.where((patient) {
                          final name =
                              (patient.data() as Map<String, dynamic>)['name']
                                  .toString()
                                  .toLowerCase();
                          final lastname = (patient.data()
                                  as Map<String, dynamic>)['lastname']
                              .toString()
                              .toLowerCase();
                          return name.contains(_searchQuery) ||
                              lastname.contains(_searchQuery);
                        }).toList();

                        return ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot document = filteredList[index];
                            String patientID = document.id;

                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            String patientText =
                                '${data['name']} ${data['lastname']}';
                            String patientDescription =
                                '${S.of(context)!.textBedNum}: ${data['bed_number']}\n' +
                                    (data['inspection_time'] != null
                                        ? DateFormat('dd/MM/yyyy hh:mm:ss')
                                            .format((data['inspection_time']
                                                    as Timestamp)
                                                .toDate())
                                        : '');
                            return ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: size.width * 0.5,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CalculateMEWsAndUpdateScreen(
                                                            name: data['name'],
                                                            surname: data[
                                                                'lastname'],
                                                            gender:
                                                                data['gender'],
                                                            hn: int.parse(data[
                                                                'hospital_number']),
                                                            bedNum: int.parse(data[
                                                                'bed_number']),
                                                            ward: data[
                                                                'ward_number'],
                                                            patientID:
                                                                patientID),
                                                  ),
                                                );
                                              },
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        patientText,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        patientDescription,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: const Color
                                                                .fromARGB(
                                                                255, 0, 0, 0)),
                                                      ),
                                                    )
                                                  ])),
                                        ),
                                      ),
                                      Spacer(),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdatePatientScreen(
                                                patientID: patientID,
                                                renderNextButton: false,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.gear,
                                          size: size.width * 0.05,
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.02),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MainInfo(
                                                  patientID: patientID),
                                            ),
                                          );
                                        },
                                        icon: FaIcon(
                                          FontAwesomeIcons.solidEye,
                                          size: size.width * 0.05,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Container(
                            width: size.width * 0.8,
                            child: const Text(
                              "No patient...",
                              textAlign: TextAlign.center,
                            ));
                      }
                    },
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
