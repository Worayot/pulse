import 'package:Pulse/authenticate/dataLoader.dart';
import 'package:Pulse/authenticate/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  Future<void> signup(
      {required String name,
      required String lastname,
      required String email,
      required String nurseID,
      required String contactInfo,
      required BuildContext context}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: nurseID,
      );

      User user = userCredential.user!;

      await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
        'name': name,
        'lastname': lastname,
        'email': email,
        'uid': user.uid,
        'nurse_id': nurseID,
        'contact_info': contactInfo, // You can set this value later if needed
        'created_at': Timestamp.now(),
      });

      // Handle successful registration
      print('User registered successfully!');

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const UserDataLoader()));
    } catch (e) {
      print('Registration failed: $e');
    }
  }

  Future<void> signin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const UserDataLoader()));
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {}
  }

  // Stream<QuerySnapshot> setProfile() {

  // }

  Future<void> signout({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
  }
}
