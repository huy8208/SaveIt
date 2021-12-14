import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/controller/firestore_controller.dart';
import 'package:budget_tracker_ui/controller/plaid_controller.dart';
import 'package:budget_tracker_ui/models/account.dart';
import 'package:budget_tracker_ui/pages/transaction_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  RxBool isLoading = false.obs;
  var today = DateTime.now();
  var expense = 0.0.obs;
  var savings = 0.0.obs;
  var thisMonth = 0.0.obs;
  final plaidrequestcontroller = Get.find<PlaidRequestController>();
  final fireStoreController = Get.find<FireStoreController>();
  final String uid = Get.find<AuthController>().getCurrentUID();

  @override
  void onInit() {
    getDataFirebase();
    super.onInit();
  }

  void getDataFirebase() {
    FirebaseFirestore.instance
        .collection("user")
        .doc(uid)
        .collection("plaid")
        .get()
        .then((listOfAccessToken) {
      //MUST CHECK IN THE listOfBankAccounts whether the accesstoken
      // already exists, otherwise if first time login and add, there will be duplicates
      if (!listOfAccessToken.docs.isEmpty) {
        listOfAccessToken.docs.forEach((document) async {
          var access_token = document.data()['access_token'].keys.first;
          var bankName = document.data()['access_token'].values.first;
          var bankAccount =
              await plaidrequestcontroller.getTransaction(access_token);
          if (!plaidrequestcontroller.listOfBankAccountWidgets
              .contains(bankAccount)) {
            plaidrequestcontroller.listOfBankAccountWidgets.add(
                TransactionsWithBankTitle(
                    bankName: bankName, bankAccount: bankAccount));
            getTotalExpense(bankAccount);
            getSavings(bankAccount);
          }
        });
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  void getTotalExpense(Account bankAccount) {
    for (var expenses in bankAccount.transactions!) {
      expense.value += expenses.amount;
      var month = expenses.date.toString().split("-");
      if (month[1] == today.month.toString())
      {
        thisMonth.value += expenses.amount;
      }
    }
  }

  void getSavings(Account bankAccount) {
    for (var account in bankAccount.accounts) {
      if (account.name!.contains("Saving") || account.name!.contains("CD"))
      {
        savings.value += account.balances.current!;
        print(savings.value);
      }
    }
  }

}
