import 'dart:convert';
import 'dart:io';
import 'package:Pulse/services/mews_service.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:Pulse/patientinfo/mainInfo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Pulse/themes/components/header.dart';
import 'package:Pulse/themes/components/searchbarwithfilter.dart';
import 'package:Pulse/services/patient_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExportPage extends StatefulWidget {
  const ExportPage({super.key});

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  final PatientService patientService = PatientService();
  String _searchQuery = '';

  // Function to export patient data to CSV
  Future<void> _exportToCsv(
      List<Map<String, dynamic>> patientData, String patientName) async {
    try {
      // Prepare the CSV data
      List<List<String>> rows = [
        [
          "Timestamp",
          "Consciousness",
          "Temperature",
          "Heart Rate",
          "Blood Pressure",
          "Oxygen Saturation",
          "Urine",
          "Respiratory Rate",
          "MEWS Score",
          "Note",
          "Editor"
        ]
      ];

      for (var data in patientData) {
        List<String> row = [
          data['timestamp'] != null
              ? DateFormat('dd/MM/yyyy HH:mm:ss')
                  .format(data['timestamp'].toDate())
              : 'N/A',
          data['consciousness'] ?? 'N/A',
          data['temperature']?.toString() ?? 'N/A',
          data['heart_rate']?.toString() ?? 'N/A',
          data['blood_pressure']?.toString() ?? 'N/A',
          data['oxygen_saturation']?.toString() ?? 'N/A',
          data['urine'] ?? 'N/A',
          data['respiratory_rate']?.toString() ?? 'N/A',
          data['mews_score']?.toString() ?? 'N/A',
          data['note'] ?? 'N/A',
          data['audit_by'] ?? 'N/A',
        ];
        rows.add(row);
      }

      String csvData = const ListToCsvConverter().convert(rows);

      // Add UTF-8 BOM
      final String utf8Bom = '\uFEFF'; // BOM for UTF-8
      csvData = utf8Bom + csvData;

      // Define the path for the public Downloads directory
      final Directory downloadsDirectory =
          Directory('/storage/emulated/0/Download');

      // Create the Downloads folder if it doesn't exist (optional)
      if (!(await downloadsDirectory.exists())) {
        await downloadsDirectory.create(recursive: true);
      }

      // Create a valid filename by replacing spaces and special characters
      patientName = patientName.replaceAll(RegExp(r'[\/:*?"<>|]'), '');
      patientName = patientName.replaceAll(' ', '_');

      // Check for duplicates and modify the file name if necessary
      String fileName = '$patientName.csv';
      int counter = 1;

      while (await File('${downloadsDirectory.path}/$fileName').exists()) {
        fileName = '${patientName}($counter).csv';
        counter++;
      }

      // Save the CSV file using the modified file name
      final File file = File('${downloadsDirectory.path}/$fileName');
      await file.writeAsString(csvData,
          encoding: utf8); // Ensure it's written as UTF-8

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data exported to ${file.path}'),
          backgroundColor: Colors.green, // Set the background color to green
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to export data: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1)),
      );
    }
  }

  // Function to handle fetching data and exporting it
  Future<void> _fetchAndExportData(String patientID, String patientName) async {
    try {
      List<Map<String, dynamic>> exportData = await MewsService()
          .getMewsData(patientID); // Fetch data on button click
      if (exportData.isNotEmpty) {
        _exportToCsv(exportData, patientName); // Call your export function
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('No data available for export.'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 1)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error fetching data: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1)),
      );
    }
  }

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
                      S.of(context)!.exportData,
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
                            String subtitleText =
                                '${S.of(context)!.textBedNum}: ${data['bed_number']}';

                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 0.5),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.01, horizontal: 16.0),
                                title: Text(patientText,
                                    style: TextStyle(fontSize: 16)),
                                subtitle: Text(subtitleText,
                                    style: TextStyle(fontSize: 12)),
                                trailing: IconButton(
                                  icon: Icon(Icons.download),
                                  onPressed: () {
                                    // Fetch and export data for the selected patient
                                    _fetchAndExportData(patientID,
                                        '${data['name']}_${data['lastname']}');
                                  },
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MainInfo(patientID: patientID),
                                    ),
                                  );
                                },
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
      ),
    );
  }
}
