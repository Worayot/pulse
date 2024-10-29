import 'package:cloud_firestore/cloud_firestore.dart';

class MewsService {
  final CollectionReference mews =
      FirebaseFirestore.instance.collection('MEWS');
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addNewNote(String patientID, String note) async {
    try {
      // Query for the most recent document for the given patientID
      QuerySnapshot snapshot = await mews
          .where('patient_id', isEqualTo: patientID)
          .orderBy('timestamp', descending: true)
          .limit(1) // Fetch only the latest document
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Get the reference of the first document in the snapshot
        DocumentReference docRef = snapshot.docs.first.reference;

        // Update the 'note' field with the new note
        await docRef.update({'note': note});
        print("Successfully updated the note.");
      } else {
        print("No document found for the given patient ID.");
      }
    } catch (e) {
      print("Error updating note: $e");
    }
  }

  static Future<void> addMEWsToPatient({
    required String? blood_pressure,
    required String? consciousness,
    required int? heart_rate,
    required int? mews_score,
    required int? oxygen_saturation,
    required double? temperature,
    required int? urine,
    required int? respiratory_rate,
    required String? patient_id,
    required String uid,
  }) async {
    try {
      // Fetch the user document by uid
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      // Check if the user document exists and retrieve name and lastname
      String name = '';
      String lastname = '';

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        name = userData['name'] ?? '';
        lastname = userData['lastname'] ?? '';
      } else {
        print("User with uid $uid not found.");
      }

      // Add MEWS data
      await FirebaseFirestore.instance.collection('MEWS').add({
        'blood_pressure': blood_pressure ?? '-',
        'consciousness': consciousness ?? '-',
        'heart_rate': heart_rate ?? '-',
        'temperature': temperature ?? '-',
        'oxygen_saturation': oxygen_saturation ?? '-',
        'respiratory_rate': respiratory_rate ?? '-',
        'urine': urine ?? '-',
        'mews_score': mews_score ?? '-',
        'patient_id': patient_id ?? '-',
        'audit_by': '$name $lastname',
        'note': '-',
        'timestamp': Timestamp.now(),
      });

      print("MEWS data added successfully.");
    } catch (e) {
      print("Error adding MEWS data: $e");
    }
  }

  static Future<void> addMEWsToPatientAndNote({
    required String? blood_pressure,
    required String? consciousness,
    required String? heart_rate,
    required String? mews_score,
    required String? oxygen_saturation,
    required String? temperature,
    required String? urine,
    required String? respiratory_rate,
    required String? patient_id,
    required String? note,
    required String uid,
  }) async {
    try {
      // Fetch the user document by uid
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      // Check if the user document exists and retrieve name and lastname
      String name = '';
      String lastname = '';

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        name = userData['name'] ?? '';
        lastname = userData['lastname'] ?? '';
      } else {
        print("User with uid $uid not found.");
      }

      // Add MEWS data
      await FirebaseFirestore.instance.collection('MEWS').add({
        'blood_pressure': blood_pressure ?? '-',
        'consciousness': consciousness ?? '-',
        'heart_rate': heart_rate ?? '-',
        'temperature': temperature ?? '-',
        'oxygen_saturation': oxygen_saturation ?? '-',
        'respiratory_rate': respiratory_rate ?? '-',
        'urine': urine ?? '-',
        'mews_score': mews_score ?? '-',
        'patient_id': patient_id ?? '-',
        'audit_by': '$name $lastname',
        'note': note,
        'timestamp': Timestamp.now(),
      });

      print("MEWS data added successfully.");
    } catch (e) {
      print("Error adding MEWS data: $e");
    }
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

  Future<String?> getLatestNoteByPatientId(String patientId) async {
    try {
      QuerySnapshot snapshot = await mews
          .where('patient_id', isEqualTo: patientId)
          .orderBy('timestamp', descending: true)
          .limit(1) // Limit to 1 document
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first['note'] as String; // Return the latest note
      } else {
        return null; // No notes found
      }
    } catch (e) {
      print("Error fetching latest note: $e");
      return null; // Return null in case of an error
    }
  }
}
