// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/controller/firestore_controller.dart';
import 'package:budget_tracker_ui/db/secure_storage_CRUD.dart';
import 'package:budget_tracker_ui/models/account.dart';
import 'package:budget_tracker_ui/pages/transaction_page.dart';
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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final body = jsonEncode(<String, dynamic>{
  "client_id": CLIENT_ID,
  "secret": SECRET_KEY,
  "client_name": "HUY HELLO",
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
  RxList<Widget> listOfBankAccounts = <Widget>[].obs;
  var bankName = "".obs;

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
      FireStoreController.createPlaidAccessToken(accessToken);
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

  Future<Account> getTransaction(
      String accessToken, String startDate, String endDate) async {
    final response = await post(Uri.parse(RETRIEVE_TRANSACTIONS_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "client_id": CLIENT_ID,
          "secret": SECRET_KEY,
          "access_token": accessToken,
          "start_date": startDate,
          "end_date": endDate,
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
    // Initialize DateTime variables
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    final oneMonthAgo =
        formatter.format(DateTime.now().subtract(const Duration(days: 31)));
    var currentDate = formatter.format(DateTime.now());
    //TO-DO: NEED TO HANDLE ERROR HERE IF CONNECTION TROUBLES

    try {
      var accessToken = await getAccessToken(publicToken);
      bankAccount = await getTransaction(accessToken, oneMonthAgo, currentDate);
      bankName.value = metadata.institution.name;
      //TO-DO: SAVE TO LOCAL STORAGE
      final storage = new FlutterSecureStorage();
      List<dynamic>? localAccounts = await loadAllAccountsFromLocalStorage();
      if (localAccounts != null) {
        localAccounts.add(bankAccount);
        storage.write(
            key: "local_transactions_data", value: json.encode(localAccounts));
      }
      listOfBankAccounts
          .add(TransactionsWithBankTitle(bankAccount: bankAccount));
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
