import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  // Method to get user details from Firestore
  Future<Map<String, String>> getUserDetails(String uid) async {
    try {
      // Query Firestore to find a document where the uid matches
      QuerySnapshot querySnapshot =
          await users.where('uid', isEqualTo: uid).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Extract user data from the first document found
        Map<String, dynamic> data =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        return {
          'name': data['name'] ?? '',
          'lastname': data['lastname'] ?? '',
          'email': data['email'] ?? '',
          'nurseID': data['nurse_id'] ?? '',
          'contactInfo': data['contact_info'] ?? '',
        };
      } else {
        throw Exception('User not found');
      }
    } catch (e) {
      print('Failed to fetch user details: $e');
      return {};
    }
  }

  Future<void> updateProfile({
    required String uid,
    required String name,
    required String lastname,
    required String contactInfo,
  }) async {
    try {
      await users.doc(uid).update({
        'name': name,
        'lastname': lastname,
        'contact_info': contactInfo,
      });
    } catch (e) {
      print('Failed to update user profile: $e');
      throw e;
    }
  }
}
