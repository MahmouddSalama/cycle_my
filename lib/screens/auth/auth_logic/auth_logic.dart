import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cycle_my/screens/auth/auth_logic/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../body/adminbody/screens/home_screen.dart';
import '../../body/userbody/screens/allow_location_screen.dart';

class AuthLogic {
  static Login(context, {required String email, required String pass}) async {
    String error = '';
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: pass,
      )
          .then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AuthState()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
      }
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('InValid data'),
                content: Text(
                  error,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('ok'))
                ],
              ));
    } catch (e) {
      //print(e);
    }
  }

  static Register(context,
      {required String email,
      required String pass,
      required String userName,
      required String phone,
      required String fullName,

      }) async {
    String error = '';
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.toLowerCase().trim(),
        password: pass.trim(),
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'id': FirebaseAuth.instance.currentUser!.uid,
        'fullName': fullName,
        'email': email,
        'userName': userName,
        'phone': pass,
        'createdAt': Timestamp.now(),
        'admin': false,
        'password': pass,
      }).then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AuthState()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'pass word is very week';
      } else if (e.code == 'email-already-in-use') {
        error = 'this email already used';
      }
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('InValid data'),
                content: Text(
                  error,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('ok'))
                ],
              ));
    } catch (e) {
      print(e);
    }
  }
}
