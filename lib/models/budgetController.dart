import 'package:budget_tracker_ui/models/budget.dart';
import 'package:budget_tracker_ui/pages/sign_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetDB {
  static final FirebaseFirestore _userData = FirebaseFirestore.instance;
  static String uid = SignInPage.getCurrentUID();
  final CollectionReference _collectionRef =
      _userData.collection('user').doc(uid).collection('budgets');

  Stream<List<Budgets>> getAllBudgets() {
    return _collectionRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Budgets.fromSnapshot(doc)).toList();
    });
  }
}

class BudgetController extends GetxController {
  final budgets = <Budgets>[].obs;

  @override
  void onInit() {
    budgets.bindStream(BudgetDB().getAllBudgets());
    super.onInit();
  }

  static final FirebaseFirestore _userData = FirebaseFirestore.instance;
  static String uid = SignInPage.getCurrentUID();

  Future createBudgets(
      String budget_Catagory, double budget_TotalAmount) async {
    _userData.collection('user').doc(uid).collection('budgets').add({
      'budget_Catagory': budget_Catagory,
      'budget_TotalAmount': budget_TotalAmount,
      'current_Amount': 0.00
    });
    update();
  }

  Future<void> deleteBudet(String id) async {
    await _userData
        .collection('user')
        .doc(uid)
        .collection('budgets')
        .doc(id)
        .delete();
    update();
  }

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
