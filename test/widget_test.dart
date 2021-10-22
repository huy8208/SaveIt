// // // This is a basic Flutter widget test.
// // //
// // // To perform an interaction with a widget in your test, use the WidgetTester
// // // utility that Flutter provides. For example, you can send tap and scroll
// // // gestures. You can also use WidgetTester to find child widgets in the widget
// // // tree, read text, and verify that the values of widget properties are correct.

// // import 'package:flutter/material.dart';
// // import 'package:flutter_test/flutter_test.dart';

// // import 'package:budget_tracker_ui/main.dart';

// // To parse this JSON data, do
// //
// //     final account = accountFromJson(jsonString);

// import 'dart:convert';

// Account accountFromJson(String str) => Account.fromJson(json.decode(str));

// String accountToJson(Account data) => json.encode(data.toJson());

// // To parse this JSON data, do
// //
// //     final account = accountFromJson(jsonString);

// class Account {
//   Account({
//     required this.accounts,
//     required this.item,
//     required this.numbers,
//     required this.requestId,
//   });

//   List<AccountElement> accounts;
//   Item item;
//   Numbers numbers;
//   String? requestId;

//   factory Account.fromJson(Map<String, dynamic> json) => Account(
//         accounts: List<AccountElement>.from(
//             json["accounts"].map((x) => AccountElement.fromJson(x))),
//         item: Item.fromJson(json["item"]),
//         numbers: Numbers.fromJson(json["numbers"]),
//         requestId: json["request_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "accounts": List<dynamic>.from(accounts.map((x) => x.toJson())),
//         "item": item.toJson(),
//         "numbers": numbers.toJson(),
//         "request_id": requestId,
//       };
// }

// class AccountElement {
//   AccountElement({
//     required this.accountId,
//     required this.balances,
//     required this.mask,
//     required this.name,
//     required this.officialName,
//     required this.subtype,
//     required this.type,
//   });

//   String? accountId;
//   Balances balances;
//   String? mask;
//   String? name;
//   String? officialName;
//   String? subtype;
//   String? type;

//   factory AccountElement.fromJson(Map<String, dynamic> json) => AccountElement(
//         accountId: json["account_id"],
//         balances: Balances.fromJson(json["balances"]),
//         mask: json["mask"],
//         name: json["name"],
//         officialName:
//             json["official_name"] == null ? null : json["official_name"],
//         subtype: json["subtype"],
//         type: json["type"],
//       );

//   Map<String, dynamic> toJson() => {
//         "account_id": accountId,
//         "balances": balances.toJson(),
//         "mask": mask,
//         "name": name,
//         "official_name": officialName == null ? null : officialName,
//         "subtype": subtype,
//         "type": type,
//       };
// }

// class Balances {
//   Balances({
//     required this.available,
//     required this.current,
//     required this.isoCurrencyCode,
//     required this.limit,
//     required this.unofficialCurrencyCode,
//   });

//   int? available;
//   double? current;
//   String? isoCurrencyCode;
//   int? limit;
//   dynamic unofficialCurrencyCode;

//   factory Balances.fromJson(Map<String, dynamic> json) => Balances(
//         available: json["available"] == null ? null : json["available"],
//         current: json["current"].toDouble(),
//         isoCurrencyCode: json["iso_currency_code"],
//         limit: json["limit"] == null ? null : json["limit"],
//         unofficialCurrencyCode: json["unofficial_currency_code"],
//       );

//   Map<String, dynamic> toJson() => {
//         "available": available == null ? null : available,
//         "current": current,
//         "iso_currency_code": isoCurrencyCode,
//         "limit": limit == null ? null : limit,
//         "unofficial_currency_code": unofficialCurrencyCode,
//       };
// }

// class Item {
//   Item({
//     required this.availableProducts,
//     required this.billedProducts,
//     required this.consentExpirationTime,
//     required this.error,
//     required this.institutionId,
//     required this.itemId,
//     required this.updateType,
//     required this.webhook,
//   });

//   List<String> availableProducts;
//   List<String> billedProducts;
//   dynamic consentExpirationTime;
//   dynamic error;
//   String? institutionId;
//   String? itemId;
//   String? updateType;
//   String? webhook;

//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//         availableProducts:
//             List<String>.from(json["available_products"].map((x) => x)),
//         billedProducts:
//             List<String>.from(json["billed_products"].map((x) => x)),
//         consentExpirationTime: json["consent_expiration_time"],
//         error: json["error"],
//         institutionId: json["institution_id"],
//         itemId: json["item_id"],
//         updateType: json["update_type"],
//         webhook: json["webhook"],
//       );

//   Map<String, dynamic> toJson() => {
//         "available_products":
//             List<dynamic>.from(availableProducts.map((x) => x)),
//         "billed_products": List<dynamic>.from(billedProducts.map((x) => x)),
//         "consent_expiration_time": consentExpirationTime,
//         "error": error,
//         "institution_id": institutionId,
//         "item_id": itemId,
//         "update_type": updateType,
//         "webhook": webhook,
//       };
// }

// class Numbers {
//   Numbers({
//     required this.ach,
//     required this.bacs,
//     required this.eft,
//     required this.international,
//   });

//   List<Ach> ach;
//   List<dynamic> bacs;
//   List<dynamic> eft;
//   List<dynamic> international;

//   factory Numbers.fromJson(Map<String, dynamic> json) => Numbers(
//         ach: List<Ach>.from(json["ach"].map((x) => Ach.fromJson(x))),
//         bacs: List<dynamic>.from(json["bacs"].map((x) => x)),
//         eft: List<dynamic>.from(json["eft"].map((x) => x)),
//         international: List<dynamic>.from(json["international"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "ach": List<dynamic>.from(ach.map((x) => x.toJson())),
//         "bacs": List<dynamic>.from(bacs.map((x) => x)),
//         "eft": List<dynamic>.from(eft.map((x) => x)),
//         "international": List<dynamic>.from(international.map((x) => x)),
//       };
// }

// class Ach {
//   Ach({
//     required this.account,
//     required this.accountId,
//     required this.routing,
//     required this.wireRouting,
//   });

//   String? account;
//   String? accountId;
//   String? routing;
//   String? wireRouting;

//   factory Ach.fromJson(Map<String, dynamic> json) => Ach(
//         account: json["account"],
//         accountId: json["account_id"],
//         routing: json["routing"],
//         wireRouting: json["wire_routing"],
//       );

//   Map<String, dynamic> toJson() => {
//         "account": account,
//         "account_id": accountId,
//         "routing": routing,
//         "wire_routing": wireRouting,
//       };
// }

// void main() {
//   var jsonob = jsonEncode({
//     "accounts": [
//       {
//         "account_id": "XAA16qGy3MfzDamvlz9jiggq6WL94NHdyLDdE",
//         "balances": {
//           "available": 100,
//           "current": 110,
//           "iso_currency_code": "USD",
//           "limit": null,
//           "unofficial_currency_code": null
//         },
//         "mask": "0000",
//         "name": "Plaid Checking",
//         "official_name": "Plaid Gold Standard 0% Interest Checking",
//         "subtype": "checking",
//         "type": "depository"
//       },
//       {
//         "account_id": "DkkR6pqPEWc9zoPM59qDseejvwX96BFvnJZvJ",
//         "balances": {
//           "available": 200,
//           "current": 210,
//           "iso_currency_code": "USD",
//           "limit": null,
//           "unofficial_currency_code": null
//         },
//         "mask": "1111",
//         "name": "Plaid Saving",
//         "official_name": "Plaid Silver Standard 0.1% Interest Saving",
//         "subtype": "savings",
//         "type": "depository"
//       },
//       {
//         "account_id": "VEE16VLbzQF1V3nk51QLSkkJXmWgnbTWREDWZ",
//         "balances": {
//           "available": null,
//           "current": 1000,
//           "iso_currency_code": "USD",
//           "limit": null,
//           "unofficial_currency_code": null
//         },
//         "mask": "2222",
//         "name": "Plaid CD",
//         "official_name": "Plaid Bronze Standard 0.2% Interest CD",
//         "subtype": "cd",
//         "type": "depository"
//       },
//       {
//         "account_id": "wkkAwylW6pc9JnQkV9jpsbbPK5v8x6frLmQrz",
//         "balances": {
//           "available": null,
//           "current": 410,
//           "iso_currency_code": "USD",
//           "limit": 2000,
//           "unofficial_currency_code": null
//         },
//         "mask": "3333",
//         "name": "Plaid Credit Card",
//         "official_name": "Plaid Diamond 12.5% APR Interest Credit Card",
//         "subtype": "credit card",
//         "type": "credit"
//       },
//       {
//         "account_id": "5AAxR3bvXNfzDBkrEzNwiddZqkbzemCZg86Zy",
//         "balances": {
//           "available": 43200,
//           "current": 43200,
//           "iso_currency_code": "USD",
//           "limit": null,
//           "unofficial_currency_code": null
//         },
//         "mask": "4444",
//         "name": "Plaid Money Market",
//         "official_name": "Plaid Platinum Standard 1.85% Interest Money Market",
//         "subtype": "money market",
//         "type": "depository"
//       },
//       {
//         "account_id": "Jjja6AxMyzCLK7MA5LkdTjjXA4kzrBudZknd6",
//         "balances": {
//           "available": null,
//           "current": 320.76,
//           "iso_currency_code": "USD",
//           "limit": null,
//           "unofficial_currency_code": null
//         },
//         "mask": "5555",
//         "name": "Plaid IRA",
//         "official_name": null,
//         "subtype": "ira",
//         "type": "investment"
//       },
//       {
//         "account_id": "kNNbPLD7RatBPVeo1B39UGGmQ57gqbhWwomW5",
//         "balances": {
//           "available": null,
//           "current": 23631.9805,
//           "iso_currency_code": "USD",
//           "limit": null,
//           "unofficial_currency_code": null
//         },
//         "mask": "6666",
//         "name": "Plaid 401k",
//         "official_name": null,
//         "subtype": "401k",
//         "type": "investment"
//       },
//       {
//         "account_id": "lPPWjpDeR4C6aM9Vl634i55ql3BeArCZJRMZV",
//         "balances": {
//           "available": null,
//           "current": 65262,
//           "iso_currency_code": "USD",
//           "limit": null,
//           "unofficial_currency_code": null
//         },
//         "mask": "7777",
//         "name": "Plaid Student Loan",
//         "official_name": null,
//         "subtype": "student",
//         "type": "loan"
//       },
//       {
//         "account_id": "qZZXMWDL6eiB5gN7nBMeUzzbeKjQoqfdoRQdq",
//         "balances": {
//           "available": null,
//           "current": 56302.06,
//           "iso_currency_code": "USD",
//           "limit": null,
//           "unofficial_currency_code": null
//         },
//         "mask": "8888",
//         "name": "Plaid Mortgage",
//         "official_name": null,
//         "subtype": "mortgage",
//         "type": "loan"
//       }
//     ],
//     "item": {
//       "available_products": [
//         "assets",
//         "balance",
//         "credit_details",
//         "identity",
//         "income",
//         "investments",
//         "liabilities",
//         "transactions"
//       ],
//       "billed_products": ["auth"],
//       "consent_expiration_time": null,
//       "error": null,
//       "institution_id": "ins_3",
//       "item_id": "wkkAwylW6pc9JnQkV9jpsbb1Z734KLFr4lZyd",
//       "update_type": "background",
//       "webhook": ""
//     },
//     "numbers": {
//       "ach": [
//         {
//           "account": "1111222233330000",
//           "account_id": "XAA16qGy3MfzDamvlz9jiggq6WL94NHdyLDdE",
//           "routing": "011401533",
//           "wire_routing": "021000021"
//         },
//         {
//           "account": "1111222233331111",
//           "account_id": "DkkR6pqPEWc9zoPM59qDseejvwX96BFvnJZvJ",
//           "routing": "011401533",
//           "wire_routing": "021000021"
//         }
//       ],
//       "bacs": [],
//       "eft": [],
//       "international": []
//     },
//     "request_id": "nBVpGax4pCU5b6N"
//   });
//   Account yes = accountFromJson(jsonob);
//   print(yes.accounts);
//   // print(jsonDecode(jsonob));
// }
