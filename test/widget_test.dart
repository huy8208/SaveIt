// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:budget_tracker_ui/main.dart';

// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';
import 'package:budget_tracker_ui/models/account.dart';

void main() {
  var jsonob = jsonEncode({
    "accounts": [
      {
        "account_id": "aZ76VpEgYLiqN4kv85agipYMX6bNr0tZzmQk5",
        "balances": {
          "available": 6400,
          "current": 0,
          "iso_currency_code": "USD",
          "limit": 6400,
          "unofficial_currency_code": null
        },
        "mask": "0362",
        "name": "CREDIT CARD",
        "official_name": "Amazon Prime Rewards Visa Signature",
        "subtype": "credit card",
        "type": "credit"
      },
      {
        "account_id": "4MDx8yak13uvjNDyP1mXHxX1np567YfkZvV58",
        "balances": {
          "available": 4390.25,
          "current": 4390.25,
          "iso_currency_code": "USD",
          "limit": null,
          "unofficial_currency_code": null
        },
        "mask": "5755",
        "name": "CHASE SAVINGS",
        "official_name": null,
        "subtype": "savings",
        "type": "depository"
      },
      {
        "account_id": "rm3ayeMYL8FnqxLVpAdRh68Dw73mL9IBnzQ4b",
        "balances": {
          "available": 3243.51,
          "current": 3243.51,
          "iso_currency_code": "USD",
          "limit": null,
          "unofficial_currency_code": null
        },
        "mask": "7971",
        "name": "TOTAL CHECKING",
        "official_name": null,
        "subtype": "checking",
        "type": "depository"
      }
    ],
    "item": {
      "available_products": ["balance", "transactions"],
      "billed_products": ["auth"],
      "consent_expiration_time": null,
      "error": null,
      "institution_id": "ins_3",
      "item_id": "yxj1reMQy8iBvEyn7Pk8t6qmno0aXJUp1XQaX",
      "update_type": "background",
      "webhook": ""
    },
    "numbers": {
      "ach": [
        {
          "account": "3797535755",
          "account_id": "4MDx8yak13uvjNDyP1mXHxX1np567YfkZvV58",
          "routing": "322271627",
          "wire_routing": null
        },
        {
          "account": "530557971",
          "account_id": "rm3ayeMYL8FnqxLVpAdRh68Dw73mL9IBnzQ4b",
          "routing": "322271627",
          "wire_routing": null
        }
      ],
      "bacs": [],
      "eft": [],
      "international": []
    },
    "request_id": "Y00wUGJyeRKC0e7"
  });
  Account yes = accountFromJson(jsonob);
  print(yes.totalTransactions);
  // print(jsonDecode(jsonob));
}
