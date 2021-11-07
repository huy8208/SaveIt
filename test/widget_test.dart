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
      "available_products": ["balance"],
      "billed_products": ["auth", "transactions"],
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
    "request_id": "MjEj27uH6ORDzGF",
    "total_transactions": 135,
    "transactions": [
      {
        "account_id": "rm3ayeMYL8FnqxLVpAdRh68Dw73mL9IBnzQ4b",
        "account_owner": null,
        "amount": 121.77,
        "authorized_date": null,
        "authorized_datetime": null,
        "category": ["Payment", "Credit Card"],
        "category_id": "16001000",
        "check_number": null,
        "date": "2021-10-01",
        "datetime": null,
        "iso_currency_code": "USD",
        "location": {
          "address": null,
          "city": null,
          "country": null,
          "lat": null,
          "lon": null,
          "postal_code": null,
          "region": null,
          "store_number": null
        },
        "merchant_name": null,
        "name": "APPLECARD GSBANK PAYMENT 1396962 WEB ID: 9999999999",
        "payment_channel": "other",
        "payment_meta": {
          "by_order_of": null,
          "payee": null,
          "payer": null,
          "payment_method": null,
          "payment_processor": null,
          "ppd_id": null,
          "reason": null,
          "reference_number": null
        },
        "pending": false,
        "pending_transaction_id": null,
        "personal_finance_category": null,
        "transaction_code": null,
        "transaction_id": "1Mwraqj36PuKxzRy768wuXjkokVYqyCmY46D1",
        "transaction_type": "special",
        "unofficial_currency_code": null
      }
    ]
  });
  Account account = accountFromJson(jsonob);
  print(account.getTransactionAt(0));
  // print(jsonDecode(jsonob));
}
