import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  static final FirebaseAuth _userCredentials = FirebaseAuth.instance;
  RxBool isAuthenticated = false.obs;
  late final currentUser;

  Future<void> signIn(String email, String password) async {
    try {
      currentUser = await _userCredentials.signInWithCredential(
          EmailAuthProvider.credential(email: email, password: password));
      isAuthenticated.value = true;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    try {
      currentUser = await _userCredentials.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      isAuthenticated.value = true;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    return await _userCredentials.signOut();
  }

  String getCurrentUID() {
    return (_userCredentials.currentUser)!.uid.toString();
  }

  String getCurrentEmail() {
    return (_userCredentials.currentUser!.email.toString());
  }

  getCurrentUser() async {
    return await (_userCredentials.currentUser!);
  }

  ChangePassword(newPassword) async {
    return await (_userCredentials.currentUser!.updatePassword(newPassword));
  }
}
