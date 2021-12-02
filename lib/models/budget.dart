import 'package:cloud_firestore/cloud_firestore.dart';

class Budgets {
  final String budget_Catagory;
  final double budget_TotalAmount;
  final double current_Amount;
  final String docID;

  const Budgets(
      {required this.budget_Catagory,
      required this.budget_TotalAmount,
      required this.current_Amount,
      required this.docID});

  static Budgets fromSnapshot(DocumentSnapshot snapshot) {
    Budgets budgets = Budgets(
        budget_Catagory: snapshot['budget_Catagory'],
        budget_TotalAmount: snapshot['budget_TotalAmount'],
        current_Amount: snapshot['current_Amount'],
        docID: snapshot.id);
    return budgets;
  }
}
