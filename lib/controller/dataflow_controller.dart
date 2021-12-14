import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/controller/firestore_controller.dart';
import 'package:budget_tracker_ui/controller/plaid_controller.dart';
import 'package:budget_tracker_ui/models/account.dart';
import 'package:budget_tracker_ui/pages/transaction_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

var dayToStr = <int, String>{
  1: "Mon",
  2: "Tue",
  3: "Wed",
  4: "Thur",
  5: "Fri",
  6: "Sat",
  7: "Sun"
};

class DataController extends GetxController {
  RxBool isLoading = false.obs;
  var total = 0.0.obs;
  var savings = 0.0.obs;
  var spend = 0.0.obs;
  final plaidrequestcontroller = Get.find<PlaidRequestController>();
  final fireStoreController = Get.find<FireStoreController>();
  // final String uid = Get.find<AuthController>().getCurrentUID();
  RxList<double> listOfExpenseEachDay = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0].obs;
  RxDouble pastWeekExpense = 0.0.obs;

  void startDataFlow() async {
    var listOfAccessToken = await getDataFirebase();
    if (!listOfAccessToken.docs.isEmpty) {
      plaidrequestcontroller.listOfBankAccounts.value =
          await getListOfBankAccounts(listOfAccessToken);
      populateTransList(plaidrequestcontroller.listOfBankAccounts);
      getEachDayExpense(plaidrequestcontroller.listOfBankAccounts);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDataFirebase() async {
    var document = await FirebaseFirestore.instance
        .collection("user")
        .doc(Get.find<AuthController>().getCurrentUID())
        .collection("plaid")
        .get();
    return document;
  }

  Future<List<Account>> getListOfBankAccounts(
      QuerySnapshot listOfAccessToken) async {
    List<Account> listOfBankAccounts = [];
    for (var document in listOfAccessToken.docs) {
      var access_token = document['access_token'].keys.first;
      var bankName = document['access_token'].values.first;
      var bankAccount =
          await plaidrequestcontroller.getTransaction(access_token);
      bankAccount.bankName = bankName;
      listOfBankAccounts.add(bankAccount);
    }
    return listOfBankAccounts;
  }

  void populateTransList(List<Account> listOfBankAccounts) {
    for (var bankAccount in listOfBankAccounts) {
      plaidrequestcontroller.listOfBankAccountWidgets.add(
          TransactionsWithBankTitle(
              bankName: bankAccount.bankName,
              bankAccount:
                  bankAccount)); //, fireStoreController: fireStoreController);
      getTotalExpense(bankAccount);
      getSavings(bankAccount);
      getThisMonthSpend(bankAccount);
    }
  }

  void getEachDayExpense(List<Account> listBankAccount) {
    //     DateFormat formatter = DateFormat('yyyy-MM-dd');
    // final oneMonthAgo =
    //     formatter.format(DateTime.now().subtract(const Duration(days: 31)));
    double mon = 0.0;
    double tue = 0.0;
    double wed = 0.0;
    double thu = 0.0;
    double fri = 0.0;
    double sat = 0.0;
    double sun = 0.0;
    var oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));

    for (var account in listBankAccount) {
      for (var transaction in account.transactions!) {
        if (dayToStr[transaction.date!.weekday] == 'Mon') {
          mon += transaction.amount;
        }
        if (dayToStr[transaction.date!.weekday] == 'Tue') {
          tue += transaction.amount;
        }
        if (dayToStr[transaction.date!.weekday] == 'Wed') {
          wed += transaction.amount;
        }
        if (dayToStr[transaction.date!.weekday] == 'Thu') {
          thu += transaction.amount;
        }
        if (dayToStr[transaction.date!.weekday] == 'Fri') {
          fri += transaction.amount;
        }
        if (dayToStr[transaction.date!.weekday] == 'Sat') {
          sat += transaction.amount;
        }
        if (dayToStr[transaction.date!.weekday] == 'Sun') {
          sun += transaction.amount;
        }
      }
    }
    List<double> temp = [mon, tue, wed, thu, fri, sat, sun];
    for (int i = 0; i < listOfExpenseEachDay.length; i++) {
      listOfExpenseEachDay[i] = listOfExpenseEachDay[i] + temp[i];
    }
    pastWeekExpense.value =
        pastWeekExpense.value + listOfExpenseEachDay.reduce((a, b) => a + b);
  }

  void getTotalExpense(Account bankAccount) {
    for (var expense in bankAccount.transactions!) {
      total.value += expense.amount;
    }
    print(total.value);
  }

  void getSavings(Account bankAccount) {
    for (var account in bankAccount.accounts) {
      if (account.name!.contains("Saving") || account.name!.contains("CD")) {
        savings.value += account.balances.current!;
      }
    }
    print(savings.value);
  }

  void getThisMonthSpend(Account bankAccount) {
    var today = DateTime.now().month.toString();
    print(today);
    for (var expense in bankAccount.transactions!) {
      if (expense.date.toString().split("-")[1] == today) {
        spend.value += expense.amount;
      }
    }
    print(spend.value);
  }
}
