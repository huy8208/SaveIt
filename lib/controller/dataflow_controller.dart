import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/controller/firestore_controller.dart';
import 'package:budget_tracker_ui/controller/plaid_controller.dart';
import 'package:budget_tracker_ui/models/account.dart';
import 'package:budget_tracker_ui/pages/transaction_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  RxBool isLoading = false.obs;
  var total = 0.0.obs;
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
          }
        });
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  void getTotalExpense(Account bankAccount) {
    for (var expense in bankAccount.transactions!) {
      total.value += expense.amount;
    }
  }
}
