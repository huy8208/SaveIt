import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/models/budget.dart';
import 'package:budget_tracker_ui/pages/sign_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileDB extends GetxController {
  static final FirebaseFirestore _userData = FirebaseFirestore.instance;
  static String uid = Get.find<AuthController>().getCurrentUID();

  Future createPlaidAccessToken(String access_token) async {
    _userData.collection('user').doc(uid).collection('plaid').add({
      'access_token': '',
    });
    update();
  }

  Future<void> deletePlaidAccessToken(String id) async {
    await _userData
        .collection('user')
        .doc(uid)
        .collection('plaid')
        .doc(id)
        .delete();
    update();
  }

  Future<void> updatePlaidAccessToken(String id, String access_token) async {
    await _userData
        .collection('user')
        .doc(uid)
        .collection('plaid')
        .doc(id)
        .update({'current_Amount': access_token});
    update();
  }

  Future createProfile(
      String date_created, String dob, String email, String name) async {
    _userData
        .collection('user')
        .doc(uid)
        .set({'date_created': '', 'dob': '', 'email': '', 'name': ''});
    update();
  }

  Future<void> deleteProfile(String id) async {
    await _userData.collection('user').doc(uid).update({
      'date_created': FieldValue.delete(),
      'dob': FieldValue.delete(),
      'email': FieldValue.delete(),
      'name': FieldValue.delete(),
    });
    update();
  }

  Future<void> updateProfile(
      String date_created, String dob, String email, String name) async {
    await _userData.collection('user').doc(uid).update({
      'date_created': date_created,
      'dob': dob,
      'email': email,
      'name': name,
    });
    update();
  }
}

class Profile {
  final String date_created;
  final String dob;
  final String email;
  final String name;
  final String docID;

  const Profile(
      {required this.date_created,
      required this.dob,
      required this.email,
      required this.name,
      required this.docID});

  static Profile fromSnapshot(DocumentSnapshot snapshot) {
    Profile profile = Profile(
        date_created: snapshot['date_created'],
        dob: snapshot['dob'],
        email: snapshot['email'],
        name: snapshot['name'],
        docID: snapshot.id);
    return profile;
  }
}
