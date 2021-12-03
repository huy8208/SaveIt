import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/models/budget.dart';
import 'package:budget_tracker_ui/pages/sign_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaidAccessTokenDB {
  static final FirebaseFirestore _userData = FirebaseFirestore.instance;
  static String uid = Get.find<AuthController>().getCurrentUID();

  // return plaidAccessToken in list
  Stream<List<PlaidAccessToken>> getAccessToken() {
    return _userData
        .collection('user')
        .doc(uid)
        .collection('plaid')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PlaidAccessToken.fromSnapshot(doc))
          .toList();
    });
  }
}

class PlaidAccessTokenController extends GetxController {
  final plaidAccessToken = <PlaidAccessToken>[].obs;

  @override
  void onInit() {
    plaidAccessToken.bindStream(PlaidAccessTokenDB().getAccessToken());
    super.onInit();
  }

  static final FirebaseFirestore _userData = FirebaseFirestore.instance;
  static String uid = Get.find<AuthController>().getCurrentUID();

  RxList<Widget> listOfPlaidAccessToken = <Widget>[].obs;

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
}

//PlaidAccessToken object
class PlaidAccessToken {
  final String access_token;
  final String docID;

  const PlaidAccessToken({required this.access_token, required this.docID});

  static PlaidAccessToken fromSnapshot(DocumentSnapshot snapshot) {
    PlaidAccessToken accessToken = PlaidAccessToken(
        access_token: snapshot['access_token'], docID: snapshot.id);
    return accessToken;
  }
}

class ProfileDB {
  static final FirebaseFirestore _userData = FirebaseFirestore.instance;
  static String uid = Get.find<AuthController>().getCurrentUID();

//return profile list
  Stream<List<Profile>> getAllProfile() {
    return _userData.collection('user').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Profile.fromSnapshot(doc)).toList();
    });
  }
}

class ProfileController extends GetxController {
  static final FirebaseFirestore _userData = FirebaseFirestore.instance;
  static String uid = Get.find<AuthController>().getCurrentUID();

  final profiles = <Profile>[].obs;

  @override
  void onInit() {
    profiles.bindStream(ProfileDB().getAllProfile());
    super.onInit();
  }

  Future createProfile(
      String date_created, String dob, String email, String name) async {
    _userData
        .collection('user')
        .doc(uid)
        .set({'date_created': '', 'dob': '', 'email': '', 'name': ''});
    update();
  }

  Future<void> deleteProfile() async {
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

//profile object
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