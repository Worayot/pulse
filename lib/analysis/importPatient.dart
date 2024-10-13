import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/services/patient_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Pulse/themes/components/searchbarwithfilter.dart';

// For importing patient's names for treatment.
class ImportPatient extends StatefulWidget {
  const ImportPatient({super.key});

  @override
  State<ImportPatient> createState() => _ImportPatientState();
}

class _ImportPatientState extends State<ImportPatient> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final patientService = PatientService();

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: size.height * 0.03),
            Text(
              S.of(context)!.patientsInSystem,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            FilteringSearchBar(
              size: size,
              onSearchChanged: (query) {
                setState(() {
                  _searchQuery =
                      query.toLowerCase(); // Update the search query state
                });
              },
            ),
            SizedBox(height: size.height * 0.03),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: patientService.getNotInCarePatient(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  // Filter the data based on the search query
                  final data = snapshot.data!.where((patient) {
                    final fullName = '${patient['name']} ${patient['lastname']}'
                        .toLowerCase();
                    return fullName.contains(_searchQuery);
                  }).toList();

                  if (data.isEmpty) {
                    return Center(child: Text('No patients found.'));
                  }

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xffFFDDEC),
                    ),
                    height: size.height * 0.6,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: BorderDirectional(bottom: BorderSide()),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: size.width * 0.8,
                                    ),
                                    child: Text(
                                      "${index + 1}. ${data[index]['name']} ${data[index]['lastname']}",
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                          fontSize: size.height * 0.024,
                                        ),
                                      ),
                                      softWrap: true,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    // Show SnackBar when adding a patient to care
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${S.of(context)!.added} ${data[index]['name']} ${data[index]['lastname']} ${S.of(context)!.intoYourCare}',
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );

                                    // Retrieve user ID and set the caretaker
                                    final uid = FirebaseAuth
                                        .instance.currentUser!.uid
                                        .toString();
                                    await patientService.setCareTaker(
                                        data[index]['id'], uid);
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.circlePlus,
                                    size: size.height * 0.028,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Container(child: Text('There is no patient.'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
