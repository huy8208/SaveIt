// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:budget_tracker_ui/models/account.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart';
import 'env.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

final body = jsonEncode(<String, dynamic>{
  "client_id": CLIENT_ID,
  "secret": SECRET_KEY,
  "client_name": "HUY HELLO",
  "country_codes": ["US"],
  "language": "en",
  "user": {"client_user_id": "test_123"},
  "products": ["auth"],
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
        body: jsonEncode(<String, dynamic>{
          "client_id": CLIENT_ID,
          "secret": SECRET_KEY,
          "public_token": accessToken
        }));

    if (response.statusCode == 200) {
      // isLoading(false);
      return jsonDecode(response.body)["access_token"];
    } else {
      throw Exception('Failed to exchange Access Token');
    }
  }

  // Future<Account> createOrGetAccount(String publicToken) async{
  //   final response = await
  // }

  void _onSuccessCallback(
      String publicToken, LinkSuccessMetadata metadata) async {
    print("onSuccess: $publicToken, metadata: ${metadata.description()}");
    accessToken = await getAccessToken(publicToken);
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
