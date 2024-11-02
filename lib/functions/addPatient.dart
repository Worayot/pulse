import 'package:Pulse/screens/HomeScreen.dart';
import 'package:Pulse/services/mews_service.dart';
import 'package:Pulse/services/patient_service.dart';
import 'package:flutter/material.dart';

Future<bool> addPatient(BuildContext context, String name, String surname,
    String gender, String hn, String bedNum, String ward) async {
  final PatientService _patientService = PatientService();

  try {
    await _patientService.addPatientAndGetID(
        name: name,
        lastname: surname,
        gender: gender,
        hospital_number: hn.toString(),
        bed_number: bedNum.toString(),
        ward_number: ward,
        user_id: [],
        color: 0,
        inspection_time: null);

    // String docID = await _patientService.addPatientAndGetID(
    //     name: name,
    //     lastname: surname,
    //     gender: gender,
    //     hospital_number: hn.toString(),
    //     bed_number: bedNum.toString(),
    //     ward_number: ward,
    //     user_id: 'null',
    //     color: 0,
    //     inspection_time: DateTime.now());

    // // Call to MEWs service
    // MewsService.addMEWsToPatient(
    //     blood_pressure: null,
    //     consciousness: null,
    //     heart_rate: null,
    //     mews_score: null,
    //     oxygen_saturation: null,
    //     temperature: null,
    //     urine: null,
    //     respiratory_rate: null,
    //     patient_id: docID);

    return true; // Return true on success
  } catch (error) {
    print('Error adding patient: $error');
    return false; // Return false on error
  }
}
