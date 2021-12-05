// import 'dart:convert';

// import 'package:budget_tracker_ui/models/account.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// // TO-DO
// Future<List<dynamic>?> loadAllAccountsFromLocalStorage() async {
//   // Read transactions from local storage and return a list of all accounts
//   final storage = new FlutterSecureStorage();
//   String? accountsString = await storage.read(key: "local_transactions_data");
//   if (accountsString != null) {
//     var list = json.decode(accountsString);
//     List<dynamic> accountList = list.map((item) {
//       return accountFromJson(json.encode(item));
//     }).toList();
//     return accountList;
//   } else {
//     return null;
//   }
// }
