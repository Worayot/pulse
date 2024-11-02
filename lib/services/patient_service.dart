import 'package:cloud_firestore/cloud_firestore.dart';

class PatientService {
  final CollectionReference patients =
      FirebaseFirestore.instance.collection('Patients');

  // Future<void> addPatient(
  //     {required String name,
  //     required String lastname,
  //     required String gender,
  //     required String bed_number,
  //     required String hospital_number,
  //     required String ward_number,
  //     required String user_id,
  //     required DateTime inspection_time,
  //     required int color}) {
  //   return patients.add({
  //     'name': name,
  //     'lastname': lastname,
  //     'gender': gender,
  //     'hospital_number': hospital_number,
  //     'bed_number': bed_number,
  //     'ward_number': ward_number,
  //     'user_id': user_id,
  //     'color': color,
  //     'timestamp': Timestamp.now(),
  //     'inspection_time': inspection_time
  //   });
  // }
  Future<void> addPatient({
    required String name,
    required String lastname,
    required String gender,
    required String bed_number,
    required String hospital_number,
    required String ward_number,
    required List<dynamic> user_id,
    required int color,
  }) {
    DateTime now = DateTime.now();
    DateTime inspectionTimePlusOneHour = now.add(Duration(hours: 1));

    return patients.add({
      'name': name,
      'lastname': lastname,
      'gender': gender,
      'hospital_number': hospital_number,
      'bed_number': bed_number,
      'ward_number': ward_number,
      'user_id': user_id,
      'color': color,
      'timestamp': Timestamp.now(),
      'inspection_time': Timestamp.fromDate(inspectionTimePlusOneHour),
    });
  }

  Future<String> addPatientAndGetID(
      {required String name,
      required String lastname,
      required String gender,
      required String bed_number,
      required String hospital_number,
      required String ward_number,
      required List<dynamic> user_id,
      required DateTime? inspection_time,
      required int color}) async {
    DocumentReference docRef = await patients.add({
      'name': name,
      'lastname': lastname,
      'gender': gender,
      'hospital_number': hospital_number,
      'bed_number': bed_number,
      'ward_number': ward_number,
      'user_id': user_id,
      'color': color,
      'timestamp': Timestamp.now(),
      'inspection_time': inspection_time
    });

    return docRef.id;
  }

  Stream<QuerySnapshot> getPatientStream() {
    final patientsStream = patients.orderBy('timestamp').snapshots();
    return patientsStream;
  }

  // Stream<List<Map<String, dynamic>>> getPinhandStream(String uid) {
  //   return patients // Replace with your actual collection reference
  //       .where('user_id', isEqualTo: uid)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //           .map((doc) => {
  //                 // Include existing data
  //                 ...doc.data() as Map<String, dynamic>,
  //                 // Add document ID
  //                 'id': doc.id,
  //               })
  //           .toList());
  // }
  Stream<List<Map<String, dynamic>>> getPinhandStream(String uid) {
    return patients // Replace with your actual collection reference
        .where('user_id', arrayContains: uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => {
                  // Include existing data
                  ...doc.data() as Map<String, dynamic>,
                  // Add document ID
                  'id': doc.id,
                })
            .toList());
  }

  Future<void> setPinterest(String patientID, String uid) {
    return patients.doc(patientID).update({
      'user_id': FieldValue.arrayUnion([uid]),
      'timestamp': Timestamp.now()
    });
  }

  Future<void> removePinterest(String patientID, String uid) {
    return patients.doc(patientID).update({
      'user_id': FieldValue.arrayRemove([uid]),
      'timestamp': Timestamp.now()
    });
  }

  Future<void> updatePatientColor({required String patientID, required int color
      // required String admission_number,
      }) async {
    try {
      await patients.doc(patientID).update({
        'color': color,
        // 'admission_number': admission_number,
      });
    } catch (e) {
      print('Failed to update user profile: $e');
      throw e;
    }
  }

  Future<void> updatePatientData({
    required String patientID,
    required String name,
    required String lastname,
    required String gender,
    required String bed_number,
    required String hospital_number,
    required String ward_number,
    required DateTime inspection_time,
  }) async {
    try {
      await patients.doc(patientID).update({
        'name': name,
        'lastname': lastname,
        'gender': gender,
        'bed_number': bed_number,
        'hospital_number': hospital_number,
        'ward_number': ward_number,
        'inspection_time': inspection_time
        // 'admission_number': admission_number,
      });
    } catch (e) {
      print('Failed to update user profile: $e');
      throw e;
    }
  }

  Future<Map<String, dynamic>> getPatientById(String patientID) async {
    final snapshot = await patients.doc(patientID).get();
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<void> setInspectionTime(String patientID, DateTime inspection_time) {
    return patients.doc(patientID).update({'inspection_time': inspection_time});
  }

  // Future<void> setCareTaker(String patientID, String uid) {
  //   return patients
  //       .doc(patientID)
  //       .update({'user_id': uid, 'timestamp': Timestamp.now()});
  // }

  // Future<void> removeCareTaker(String patientID, String uid) {
  //   return patients
  //       .doc(patientID)
  //       .update({'user_id': "null", 'timestamp': Timestamp.now()});
  // }

  Future<void> deletePatient(String patientID) {
    return patients.doc(patientID).delete();
  }

  Stream<List<Map<String, dynamic>>> getNotInCarePatient() {
    return patients
        .where('user_id', isEqualTo: 'null')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => {
                  ...doc.data() as Map<String, dynamic>,
                  'id': doc.id,
                })
            .toList());
  }
}
