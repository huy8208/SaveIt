import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/models/budget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Class for accessing current user's budgets stored in Firebase
class BudgetDB {
  static final FirebaseFirestore _userData = FirebaseFirestore.instance;
  static String uid = Get.find<AuthController>().getCurrentUID();
  final CollectionReference _collectionRef =
      _userData.collection('user').doc(uid).collection('budgets');

//get all budgets of the current user from Firebase and store into a list
  Stream<List<Budgets>> getAllBudgets() {
    return _collectionRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Budgets.fromSnapshot(doc)).toList();
    });
  }
}

//Controller for accessing and modifying budgets from Firebase
class BudgetController extends GetxController {
  final budgets = <Budgets>[].obs;

  @override
  void onInit() {
    budgets.bindStream(BudgetDB().getAllBudgets());
    super.onInit();
  }

  static final FirebaseFirestore _userData = FirebaseFirestore.instance;
  static String uid = Get.find<AuthController>().getCurrentUID();

  RxList<Widget> listOfBudgets = <Widget>[].obs;

//create budget on Firebase
  Future createBudgets(
      String budget_Catagory, double budget_TotalAmount) async {
    _userData.collection('user').doc(uid).collection('budgets').add({
      'budget_Catagory': budget_Catagory,
      'budget_TotalAmount': budget_TotalAmount,
      'current_Amount': 0.00
    });
    update();
  }

//delete the budget on Firebase
  Future<void> deleteBudet(String id) async {
    await _userData
        .collection('user')
        .doc(uid)
        .collection('budgets')
        .doc(id)
        .delete();
    update();
  }

//update the amount of budget used on Firebase
  Future<void> updateBudet(String id, double budget) async {
    await _userData
        .collection('user')
        .doc(uid)
        .collection('budgets')
        .doc(id)
        .update({'current_Amount': budget});
    update();
  }
}
