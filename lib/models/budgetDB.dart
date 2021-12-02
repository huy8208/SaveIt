import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/pages/sign_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BudgetDB {
  static final FirebaseFirestore _userData = FirebaseFirestore.instance;
  static String uid = Get.find<AuthController>().getCurrentUID();
  final CollectionReference _collectionRef =
      _userData.collection('user').doc(uid).collection('budgets');

  Future getBudgetsList() async {
    List budgetList = [];
    try {
      QuerySnapshot querySnapshot = await _collectionRef.get();
      budgetList = querySnapshot.docs.map((doc) => doc.data()).toList();
      return budgetList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
