// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
  Account({
    required this.accounts,
    required this.item,
    required this.requestId,
    required this.totalTransactions,
    required this.transactions,
  });

  List<AccountElement> accounts;
  Item item;
  String requestId;
  int totalTransactions;
  List<dynamic> transactions;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        accounts: List<AccountElement>.from(
            json["accounts"].map((x) => AccountElement.fromJson(x))),
        item: Item.fromJson(json["item"]),
        requestId: json["request_id"],
        totalTransactions: json["total_transactions"],
        transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "accounts": List<dynamic>.from(accounts.map((x) => x.toJson())),
        "item": item.toJson(),
        "request_id": requestId,
        "total_transactions": totalTransactions,
        "transactions": List<dynamic>.from(transactions.map((x) => x)),
      };
}

class AccountElement {
  AccountElement({
    required this.accountId,
    required this.balances,
    required this.mask,
    required this.name,
    required this.officialName,
    required this.subtype,
    required this.type,
  });

  String accountId;
  Balances balances;
  String mask;
  String name;
  String officialName;
  String subtype;
  String type;

  factory AccountElement.fromJson(Map<String, dynamic> json) => AccountElement(
        accountId: json["account_id"],
        balances: Balances.fromJson(json["balances"]),
        mask: json["mask"],
        name: json["name"],
        officialName:
            json["official_name"] == null ? null : json["official_name"],
        subtype: json["subtype"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "account_id": accountId,
        "balances": balances.toJson(),
        "mask": mask,
        "name": name,
        "official_name": officialName == null ? null : officialName,
        "subtype": subtype,
        "type": type,
      };
}

class Balances {
  Balances({
    required this.available,
    required this.current,
    required this.isoCurrencyCode,
    required this.limit,
    required this.unofficialCurrencyCode,
  });

  int available;
  double current;
  String isoCurrencyCode;
  int limit;
  dynamic unofficialCurrencyCode;

  factory Balances.fromJson(Map<String, dynamic> json) => Balances(
        available: json["available"] == null ? null : json["available"],
        current: json["current"].toDouble(),
        isoCurrencyCode: json["iso_currency_code"],
        limit: json["limit"] == null ? null : json["limit"],
        unofficialCurrencyCode: json["unofficial_currency_code"],
      );

  Map<String, dynamic> toJson() => {
        "available": available == null ? null : available,
        "current": current,
        "iso_currency_code": isoCurrencyCode,
        "limit": limit == null ? null : limit,
        "unofficial_currency_code": unofficialCurrencyCode,
      };
}

class Item {
  Item({
    required this.availableProducts,
    required this.billedProducts,
    required this.consentExpirationTime,
    required this.error,
    required this.institutionId,
    required this.itemId,
    required this.updateType,
    required this.webhook,
  });

  List<String> availableProducts;
  List<String> billedProducts;
  dynamic consentExpirationTime;
  dynamic error;
  String institutionId;
  String itemId;
  String updateType;
  String webhook;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        availableProducts:
            List<String>.from(json["available_products"].map((x) => x)),
        billedProducts:
            List<String>.from(json["billed_products"].map((x) => x)),
        consentExpirationTime: json["consent_expiration_time"],
        error: json["error"],
        institutionId: json["institution_id"],
        itemId: json["item_id"],
        updateType: json["update_type"],
        webhook: json["webhook"],
      );

  Map<String, dynamic> toJson() => {
        "available_products":
            List<dynamic>.from(availableProducts.map((x) => x)),
        "billed_products": List<dynamic>.from(billedProducts.map((x) => x)),
        "consent_expiration_time": consentExpirationTime,
        "error": error,
        "institution_id": institutionId,
        "item_id": itemId,
        "update_type": updateType,
        "webhook": webhook,
      };
}

class Numbers {
  Numbers({
    required this.ach,
    required this.bacs,
    required this.eft,
    required this.international,
  });

  List<Ach> ach;
  List<dynamic> bacs;
  List<dynamic> eft;
  List<dynamic> international;

  factory Numbers.fromJson(Map<String, dynamic> json) => Numbers(
        ach: List<Ach>.from(json["ach"].map((x) => Ach.fromJson(x))),
        bacs: List<dynamic>.from(json["bacs"].map((x) => x)),
        eft: List<dynamic>.from(json["eft"].map((x) => x)),
        international: List<dynamic>.from(json["international"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ach": List<dynamic>.from(ach.map((x) => x.toJson())),
        "bacs": List<dynamic>.from(bacs.map((x) => x)),
        "eft": List<dynamic>.from(eft.map((x) => x)),
        "international": List<dynamic>.from(international.map((x) => x)),
      };
}

class Ach {
  Ach({
    required this.account,
    required this.accountId,
    required this.routing,
    required this.wireRouting,
  });

  String account;
  String accountId;
  String routing;
  String wireRouting;

  factory Ach.fromJson(Map<String, dynamic> json) => Ach(
        account: json["account"],
        accountId: json["account_id"],
        routing: json["routing"],
        wireRouting: json["wire_routing"],
      );

  Map<String, dynamic> toJson() => {
        "account": account,
        "account_id": accountId,
        "routing": routing,
        "wire_routing": wireRouting,
      };
}
