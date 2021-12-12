import 'package:budget_tracker_ui/controller/firestore_controller.dart';
import 'package:budget_tracker_ui/models/plaid_access_token_model.dart';
import 'package:budget_tracker_ui/utility/snackBarError.dart';
import 'package:budget_tracker_ui/utility/snackBarSuccess.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:restart_app/restart_app.dart';

class AuthController extends GetxController {
  static final FirebaseAuth _userCredentials = FirebaseAuth.instance;
  RxBool isAuthenticated = false.obs;
  late var currentUser;

  Future<void> signIn(String email, String password) async {
    try {
      currentUser = await _userCredentials.signInWithCredential(
          EmailAuthProvider.credential(email: email, password: password));
      successSnackBar("Sign-in success!");
      isAuthenticated.value = true;
    } catch (e) {
      errorSnackBar(e.toString());
      print(e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    try {
      currentUser = await _userCredentials
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((currentUser) {
        successSnackBar("Register-in success!");
        isAuthenticated.value = true;
        print(getCurrentUID());
        FireStoreController.createFireStoreUser(Timestamp.now(), "",
            currentUser.user!.email!, currentUser.user!.email!, "0");
      });
    } catch (e) {
      errorSnackBar(e.toString());
      print(e.toString());
    }
  }

//sign out current user
  Future signOut() async {
    try {
      await _userCredentials.signOut();
      isAuthenticated.value = false;
      //restart the app
      Restart.restartApp();
    } catch (e) {}
  }

//get current user id
  String getCurrentUID() {
    return (_userCredentials.currentUser)!.uid.toString();
  }

//get current user email
  String getCurrentEmail() {
    return (_userCredentials.currentUser!.email.toString());
  }

//get current user
  getCurrentUser() async {
    return await (_userCredentials.currentUser!);
  }

//change password of current user
  ChangePassword(newPassword) async {
    return await (_userCredentials.currentUser!.updatePassword(newPassword));
  }
}
