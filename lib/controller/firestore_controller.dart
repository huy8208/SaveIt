import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/models/firestore_user_model.dart';
import 'package:budget_tracker_ui/models/plaid_access_token_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;
final String uid = Get.find<AuthController>().getCurrentUID();

// create an empty user => no realtime update
// save access token => no realtime update
// get access token => no realtime update

class FireStoreController extends GetxController {
  // final accessTokenLists = <PlaidAccessToken>[].obs;
  @override
  void onInit() {
    // accessTokenLists.bindStream(getAllAccessTokens());
    super.onInit();
  }

  // ACCESS TOKEN
  Stream<List<PlaidAccessToken>> getAllAccessTokens() {
    return _db
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

  static Future createPlaidAccessToken(
      String access_token, String bankName) async {
    try {
      await _db.collection('user').doc(uid).collection('plaid').add({
        'access_token': {access_token: bankName},
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<void> deletePlaidAccessToken(String id) async {
    try {
      await _db
          .collection('user')
          .doc(uid)
          .collection('plaid')
          .doc(id)
          .delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<void> updatePlaidAccessToken(
      String id, String access_token) async {
    try {
      await _db
          .collection('user')
          .doc(uid)
          .collection('plaid')
          .doc(id)
          .update({'current_Amount': access_token});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // FIRESTORE USER
  Stream<List<FireStoreUser>> getAllUserFromFirestore() {
    return _db.collection('user').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => FireStoreUser.fromSnapshot(doc))
          .toList();
    });
  }

  static Future createFireStoreUser(Timestamp date_created, String dob,
      String email, String name, String savings_goal) async {
    try {
      await _db.collection('user').doc(uid).set({
        'date_created': date_created,
        'dob': dob,
        'email': email,
        'name': name,
        'savings_goal': savings_goal
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<void> deleteFireStoreUser(String userID) async {
    try {
      await _db.collection('user').doc(userID).update({
        'date_created': FieldValue.delete(),
        'dob': FieldValue.delete(),
        'email': FieldValue.delete(),
        'name': FieldValue.delete(),
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<void> updateFireStoreUser(
      Timestamp date_created, String dob, String email, String name) async {
    try {
      await _db.collection('user').doc(uid).update({
        'date_created': date_created,
        'dob': dob,
        'email': email,
        'name': name,
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<void> updateUserGoal(String savings_goal) async {
    try {
      await _db
          .collection('user')
          .doc(uid)
          .update({'savings_goal': savings_goal});
    } catch (e) {
      print(e);
    }
  }

  Future<String> getUserGoal() async {
    String user_goal = "0";
    await _db.collection('user').doc(uid).get().then((snapshot) {
      user_goal = snapshot.get('savings_goal');
    });
    return user_goal;
  }
}
