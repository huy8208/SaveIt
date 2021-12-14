// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/controller/dataflow_controller.dart';
import 'package:budget_tracker_ui/controller/firestore_controller.dart';
import 'package:budget_tracker_ui/db/secure_storage_CRUD.dart';
import 'package:budget_tracker_ui/models/account.dart';
import 'package:budget_tracker_ui/pages/transaction_page.dart';
import 'package:budget_tracker_ui/widget/accountCards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart';
import '../plaid/env.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:io';

final body = jsonEncode(<String, dynamic>{
  "client_id": CLIENT_ID,
  "secret": SECRET_KEY,
  "client_name": Get.find<AuthController>().getCurrentEmail(),
  "country_codes": ["US"],
  "language": "en",
  "user": {"client_user_id": "test_123"},
  "products": ["auth", "transactions"],
  "redirect_uri": REDIRECT_URL
});

class LinkToken {
  final String expiration;
  final String tokenURL;
  final String requestId;

  LinkToken(
      {required this.expiration,
      required this.tokenURL,
      required this.requestId});

  factory LinkToken.fromJson(Map<String, dynamic> json) {
    return LinkToken(
      expiration: json['expiration'],
      tokenURL: json['link_token'],
      requestId: json['request_id'],
    );
  }
}

class PlaidRequestController extends GetxController {
  // RxBool isLoading = false.obs;
  // RxBool hasError = false.obs;

  late LinkToken linkToken;
  late String accessToken;
  late Account bankAccount;
  RxList<Widget> listOfBankAccountWidgets = <Widget>[].obs;
  RxList<Account> listOfBankAccounts = <Account>[].obs;
  RxList<Widget> listOfAccountsWithinBank = <Widget>[].obs;
  final fireStoreController = Get.find<FireStoreController>();

  void openPlaidOAth() async {
    linkToken = await createLinkToken();
    LinkTokenConfiguration linkTokenConfiguration = LinkTokenConfiguration(
      token: linkToken.tokenURL,
    );

    late PlaidLink plaidLinkToken = PlaidLink(
      configuration: linkTokenConfiguration,
      onSuccess: _onSuccessCallback,
      onEvent: _onEventCallback,
      onExit: _onExitCallback,
    );
    plaidLinkToken.open();
  }

  Future<LinkToken> createLinkToken() async {
    // isLoading(true);
    final response = await post(
      Uri.parse(CREATE_LINK_TOKEN_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      // isLoading(false);
      return LinkToken.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load linkToken');
    }
  }

  Future<String> getAccessToken(String accessToken) async {
    final response = await post(Uri.parse(EXCHANGE_TOKEN_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "client_id": CLIENT_ID,
          "secret": SECRET_KEY,
          "public_token": accessToken
        }));
    if (response.statusCode == 200) {
      String accessToken = jsonDecode(response.body)["access_token"];
      return accessToken;
    } else {
      throw Exception('Failed to exchange Access Token');
    }
  }

  Future<Account> getBankAccount(String accessToken) async {
    final response = await post(Uri.parse(RETRIEVE_AUTH_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "client_id": CLIENT_ID,
          "secret": SECRET_KEY,
          "access_token": accessToken
        }));
    if (response.statusCode == 200) {
      // isLoading(false);
      return accountFromJson(response.body);
    } else {
      print(response.body);
      throw Exception('Failed to get Bank Account!');
    }
  }

  Future<Account> getTransaction(String accessToken) async {
    // Initialize DateTime variables
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    final oneMonthAgo =
        formatter.format(DateTime.now().subtract(const Duration(days: 31)));
    var currentDate = formatter.format(DateTime.now());

    final response = await post(Uri.parse(RETRIEVE_TRANSACTIONS_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "client_id": CLIENT_ID,
          "secret": SECRET_KEY,
          "access_token": accessToken,
          "start_date": oneMonthAgo,
          "end_date": currentDate,
        }));
    if (response.statusCode == 200) {
      return accountFromJson(response.body);
    } else {
      print(response.body);
      throw Exception('Failed to get Transactions!');
    }
  }

  void _onSuccessCallback(
      String publicToken, LinkSuccessMetadata metadata) async {
    print("onSuccess: $publicToken, metadata: ${metadata.description()}");

    //TO-DO: NEED TO HANDLE ERROR HERE IF CONNECTION TROUBLES

    try {
      var accessToken = await getAccessToken(publicToken);
      bankAccount = await getTransaction(accessToken);
      FireStoreController.createPlaidAccessToken(
          accessToken, metadata.institution.name);
      List<Account> listBankAccount = [];
      listBankAccount.add(bankAccount);
      listOfBankAccountWidgets.add(TransactionsWithBankTitle(
          bankName: metadata.institution.name, bankAccount: bankAccount));//, fireStoreController: fireStoreController, accessToken: accessToken));
      listOfAccountsWithinBank.add(FinalAccountCards(
          bankName: metadata.institution.name, bankAccount: bankAccount));
      Get.find<DataController>().getEachDayExpense(listBankAccount);
      var oneWeekSum = 0.0;
      for (var account in listBankAccount) {
        Get.find<DataController>().getTotalExpense(bankAccount);
        for (var transaction in account.transactions!) {
          oneWeekSum += transaction.amount;
        }
      }
      // Get.find<DataController>().pastWeekExpense.value =
      //     Get.find<DataController>().pastWeekExpense.value + oneWeekSum;
    } catch (e) {
      print(e);
      Get.defaultDialog(title: "Error! Could not fetch transactions!");
    }
  }

  void addBankAccount(RxList<Widget> list, Account bankAccount) {
    if (list.isEmpty) {
      Get.defaultDialog(title: "You have 0 transaction for this bank account.");
    }
  }

  void _onEventCallback(String event, LinkEventMetadata metadata) {
    print("onEvent: $event, metadata: ${metadata.description()}");
  }

  void _onExitCallback(LinkError? error, LinkExitMetadata metadata) {
    print("onExit metadata: ${metadata.description()}");

    if (error != null) {
      print("onExit error: ${error.description()}");
    }
  }
}
