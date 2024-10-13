import 'package:cloud_firestore/cloud_firestore.dart';

class MewsService {
  final CollectionReference mews =
      FirebaseFirestore.instance.collection('MEWS');

  static Future<void> addMEWsToPatient({
    required String blood_pressure,
    required String consciousness,
    required double heart_rate,
    required double mews_score,
    required double oxygen_saturation,
    required double temperature,
    required double urine,
    required double respiratory_rate,
    required String patient_id,
  }) {
    return FirebaseFirestore.instance.collection('MEWS').add({
      'blood_pressure': blood_pressure,
      'consciousness': consciousness,
      'heart_rate': heart_rate,
      'temperature': temperature,
      'oxygen_saturation': oxygen_saturation,
      'respiratory_rate': respiratory_rate,
      'urine': urine,
      'mews_score': mews_score,
      'patient_id': patient_id,
      'timestamp': Timestamp.now(),
    });
  }

  // Stream<DocumentSnapshot> getMewsStream(String id) {
  //   final patientStream = mews.doc(id).snapshots();
  //   return patientStream;
  // }
  Stream<List<Map<String, dynamic>>> getMewsStream(String patientID) {
    return mews
        .where('patient_id', isEqualTo: patientID)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
  }

  Stream<Map<String, dynamic>> getMewsStream2(String patientID) {
    return mews
        .where('patient_id', isEqualTo: patientID)
        .orderBy('timestamp', descending: true) // Assuming patient_id is unique
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        // Return the data of the first document as Map<String, dynamic>
        // print("success fetch");
        return snapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        // Return an empty map if no document is found
        return {};
      }
    });
  }

  // Future<void> removeCareTaker(String patientID, String uid) {
  //   return mews.doc(patientID).update({
  //     'user_id': "null",
  //     'timestamp': Timestamp.now()
  //   });
  // }

  // Future<void> deletePatient(String patientID) {
  //   return mews.doc(patientID).delete();
  // }

  static Future<List<double>> getLatestColors(String patientID) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('MEWS')
          .where('patient_id', isEqualTo: patientID)
          .orderBy('timestamp', descending: true)
          .limit(3)
          .get();

      List<double> colors =
          querySnapshot.docs.map((doc) => doc['mews_score'] as double).toList();

      return colors;
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Failed to fetch colors: $e');
      return [];
    }
  }
}
