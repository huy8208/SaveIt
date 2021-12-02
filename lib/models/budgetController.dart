import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/models/budget.dart';
import 'package:budget_tracker_ui/pages/sign_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetDB {
  static final FirebaseFirestore _userData = FirebaseFirestore.instance;
  static String uid = Get.find<AuthController>().getCurrentUID();
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
  static String uid = Get.find<AuthController>().getCurrentUID();
  final CollectionReference _collectionRef =
      _userData.collection('user').doc(uid).collection('budgets');

  Future getBudgetsList() async {
    List budgetList = [];
    try {
      QuerySnapshot querySnapshot = await _collectionRef.get();
      budgetList = querySnapshot.docs.map((doc) => doc.data()).toList();
      update();
      return budgetList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  RxList<Widget> listOfBudgets = <Widget>[].obs;

  Future createBudgets(
      String budget_Catagory, double budget_TotalAmount) async {
    _userData.collection('user').doc(uid).collection('budgets').add({
      'budget_Catagory': budget_Catagory,
      'budget_TotalAmount': budget_TotalAmount,
      'current_Amount': 0.00
    });
    update();
  }
}
