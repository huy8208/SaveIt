// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'env.dart' as environment;
import 'package:plaid_flutter/plaid_flutter.dart';

final body = jsonEncode(<String, dynamic>{
  "client_id": environment.CLIENT_ID,
  "secret": environment.SECRET_KEY,
  "client_name": "HUY HELLO",
  "country_codes": ["US"],
  "language": "en",
  "user": {"client_user_id": "test_123"},
  "products": ["auth"],
  "redirect_uri": environment.REDIRECT_URL
});

class LinkToken {
  final String expiration;
  final String linkToken;
  final String requestId;

  LinkToken(
      {required this.expiration,
      required this.linkToken,
      required this.requestId});

  factory LinkToken.fromJson(Map<String, dynamic> json) {
    return LinkToken(
      expiration: json['expiration'],
      linkToken: json['link_token'],
      requestId: json['request_id'],
    );
  }

  Future<LinkToken> createLinkToken() async {
    final response = await http.post(
      Uri.parse(environment.CREATE_LINK_TOKEN_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return LinkToken.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load linkToken');
    }
  }
}

class OAuth {
  late PlaidLink _plaidLinkToken;
    LinkTokenConfiguration linkTokenConfiguration = LinkTokenConfiguration(
      token: "GENERATED_LINK_TOKEN",
    );

    _plaidLinkToken = PlaidLink(
      configuration: linkTokenConfiguration,
      onSuccess: _onSuccessCallback,
      onEvent: _onEventCallback,
      onExit: _onExitCallback,
    );
  

  void _onSuccessCallback(String publicToken, LinkSuccessMetadata metadata) {
    print("onSuccess: $publicToken, metadata: ${metadata.description()}");
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

  open(){
   return _plaidLinkToken.open();
  }

}