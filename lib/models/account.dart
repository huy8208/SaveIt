// We can use this model to store user bank account after we pull data from Plaid Api.

import 'dart:convert';
import 'dart:core';
import 'package:get/get.dart';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
  Account(
      {required this.accounts,
      required this.item,
      required this.numbers,
      required this.requestId,
      required this.totalTransactions,
      required this.transactions,
      this.bankName = ""});

  String bankName;
  List<AccountElement> accounts;
  Item item;
  Numbers? numbers;
  String? requestId;
  int? totalTransactions;
  List<Transaction>? transactions;

  Transaction? getTransactionAt(int index) {
    if (this.transactions != null &&
        (0 <= index && index < this.transactions!.length)) {
      return this.transactions!.elementAt(index);
    } else {
      return null;
    }
  }

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        accounts: List<AccountElement>.from(
            json["accounts"].map((x) => AccountElement.fromJson(x))),
        item: Item.fromJson(json["item"]),
        numbers:
            json["numbers"] == null ? null : Numbers.fromJson(json["numbers"]),
        requestId: json["request_id"] == null ? null : json["request_id"],
        totalTransactions: json["total_transactions"] == null
            ? null
            : json["total_transactions"],
        transactions: json["transactions"] == null
            ? null
            : List<Transaction>.from(
                json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "accounts": List<dynamic>.from(accounts.map((x) => x.toJson())),
        "item": item.toJson(),
        "numbers": numbers == null ? null : numbers!.toJson(),
        "request_id": requestId,
        "total_transactions": totalTransactions,
        "transactions": transactions == null
            ? null
            : List<dynamic>.from(transactions!.map((x) => x.toJson())),
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

  String? accountId;
  Balances balances;
  String? mask;
  String? name;
  String? officialName;
  String? subtype;
  String? type;

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

  double? available;
  double? current;
  String? isoCurrencyCode;
  int? limit;
  dynamic unofficialCurrencyCode;

  factory Balances.fromJson(Map<String, dynamic> json) => Balances(
        available:
            json["available"] == null ? null : json["available"].toDouble(),
        current: json["current"] == null ? null : json["current"].toDouble(),
        isoCurrencyCode: json["iso_currency_code"],
        limit: json["limit"] == null ? null : json["limit"],
        unofficialCurrencyCode: json["unofficial_currency_code"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
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
    this.institutionName,
    required this.itemId,
    required this.updateType,
    required this.webhook,
  });

  List<String>? availableProducts;
  List<String>? billedProducts;
  dynamic consentExpirationTime;
  dynamic error;
  String institutionId;
  String? institutionName;
  String? itemId;
  String? updateType;
  String? webhook;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        availableProducts: json["available_products"] == null
            ? null
            : List<String>.from(json["available_products"].map((x) => x)),
        billedProducts: json["billed_products"] == null
            ? null
            : List<String>.from(json["billed_products"].map((x) => x)),
        consentExpirationTime: json["consent_expiration_time"],
        error: json["error"],
        institutionId: json["institution_id"],
        itemId: json["item_id"],
        updateType: json["update_type"],
        webhook: json["webhook"],
      );

  Map<String, dynamic> toJson() => {
        "available_products": availableProducts == null
            ? null
            : List<dynamic>.from(availableProducts!.map((x) => x)),
        "billed_products": billedProducts == null
            ? null
            : List<dynamic>.from(billedProducts!.map((x) => x)),
        "consent_expiration_time": consentExpirationTime,
        "error": error,
        "institution_id": institutionId,
        "institution_name_added":
            institutionName == null ? null : institutionName,
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

  List<Ach>? ach;
  List<dynamic>? bacs;
  List<dynamic>? eft;
  List<dynamic>? international;

  factory Numbers.fromJson(Map<String, dynamic> json) => Numbers(
        ach: json["ach"] == null
            ? null
            : List<Ach>.from(json["ach"].map((x) => Ach.fromJson(x))),
        bacs: json["bacs"] == null
            ? null
            : List<dynamic>.from(json["bacs"].map((x) => x)),
        eft: json["eft"] == null
            ? null
            : List<dynamic>.from(json["eft"].map((x) => x)),
        international: json["international"] == null
            ? null
            : List<dynamic>.from(json["international"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ach": ach == null
            ? null
            : List<dynamic>.from(ach!.map((x) => x.toJson())),
        "bacs": bacs == null ? null : List<dynamic>.from(bacs!.map((x) => x)),
        "eft": eft == null ? null : List<dynamic>.from(eft!.map((x) => x)),
        "international": international == null
            ? null
            : List<dynamic>.from(international!.map((x) => x)),
      };
}

class Ach {
  Ach({
    required this.account,
    required this.accountId,
    required this.routing,
    required this.wireRouting,
  });

  String? account;
  String? accountId;
  String? routing;
  dynamic wireRouting;

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

class Transaction {
  Transaction({
    required this.accountId,
    required this.accountOwner,
    required this.amount,
    required this.authorizedDate,
    required this.authorizedDatetime,
    required this.category,
    required this.categoryId,
    required this.checkNumber,
    required this.date,
    required this.datetime,
    required this.isoCurrencyCode,
    required this.location,
    required this.merchantName,
    required this.name,
    required this.paymentChannel,
    required this.paymentMeta,
    required this.pending,
    required this.pendingTransactionId,
    required this.personalFinanceCategory,
    required this.transactionCode,
    required this.transactionId,
    required this.transactionType,
    required this.unofficialCurrencyCode,
  });

  String? accountId;
  dynamic accountOwner;
  double amount;
  DateTime? authorizedDate;
  dynamic authorizedDatetime;
  List<String> category;
  String? categoryId;
  dynamic checkNumber;
  DateTime? date;
  dynamic datetime;
  String? isoCurrencyCode;
  Location? location;
  String? merchantName;
  String? name;
  String? paymentChannel;
  PaymentMeta? paymentMeta;
  bool? pending;
  dynamic pendingTransactionId;
  dynamic personalFinanceCategory;
  dynamic transactionCode;
  String? transactionId;
  String? transactionType;
  dynamic unofficialCurrencyCode;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        accountId: json["account_id"],
        accountOwner: json["account_owner"],
        amount: json["amount"].toDouble(),
        authorizedDate: json["authorized_date"] == null
            ? null
            : DateTime.parse(json["authorized_date"]),
        authorizedDatetime: json["authorized_datetime"],
        category: List<String>.from(json["category"].map((x) => x)),
        categoryId: json["category_id"],
        checkNumber: json["check_number"],
        date: DateTime.parse(json["date"]),
        datetime: json["datetime"],
        isoCurrencyCode: json["iso_currency_code"],
        location: Location.fromJson(json["location"]),
        merchantName:
            json["merchant_name"] == null ? null : json["merchant_name"],
        name: json["name"],
        paymentChannel: json["payment_channel"],
        paymentMeta: PaymentMeta.fromJson(json["payment_meta"]),
        pending: json["pending"],
        pendingTransactionId: json["pending_transaction_id"],
        personalFinanceCategory: json["personal_finance_category"],
        transactionCode: json["transaction_code"],
        transactionId: json["transaction_id"],
        transactionType: json["transaction_type"],
        unofficialCurrencyCode: json["unofficial_currency_code"],
      );

  Map<String, dynamic> toJson() => {
        "account_id": accountId,
        "account_owner": accountOwner,
        "amount": amount,
        "authorized_date": authorizedDate == null
            ? null
            : "${authorizedDate!.year.toString().padLeft(4, '0')}-${authorizedDate!.month.toString().padLeft(2, '0')}-${authorizedDate!.day.toString().padLeft(2, '0')}",
        "authorized_datetime": authorizedDatetime,
        "category": List<dynamic>.from(category.map((x) => x)),
        "category_id": categoryId,
        "check_number": checkNumber,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "datetime": datetime,
        "iso_currency_code": isoCurrencyCode,
        "location": location!.toJson(),
        "merchant_name": merchantName == null ? null : merchantName,
        "name": name,
        "payment_channel": paymentChannel,
        "payment_meta": paymentMeta!.toJson(),
        "pending": pending,
        "pending_transaction_id": pendingTransactionId,
        "personal_finance_category": personalFinanceCategory,
        "transaction_code": transactionCode,
        "transaction_id": transactionId,
        "transaction_type": transactionType,
        "unofficial_currency_code": unofficialCurrencyCode,
      };
  @override
  String toString() {
    // TODO: implement toString
    return "Pay to $name with \$$amount on $authorizedDate \n";
  }
}

class Location {
  Location({
    required this.address,
    required this.city,
    required this.country,
    required this.lat,
    required this.lon,
    required this.postalCode,
    required this.region,
    required this.storeNumber,
  });

  dynamic address;
  String? city;
  dynamic country;
  double? lat;
  double? lon;
  dynamic postalCode;
  String? region;
  String? storeNumber;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address: json["address"],
        city: json["city"] == null ? null : json["city"],
        country: json["country"],
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lon: json["lon"] == null ? null : json["lon"].toDouble(),
        postalCode: json["postal_code"],
        region: json["region"] == null ? null : json["region"],
        storeNumber: json["store_number"] == null ? null : json["store_number"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city == null ? null : city,
        "country": country,
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
        "postal_code": postalCode,
        "region": region == null ? null : region,
        "store_number": storeNumber == null ? null : storeNumber,
      };
}

class PaymentMeta {
  PaymentMeta({
    required this.byOrderOf,
    required this.payee,
    required this.payer,
    required this.paymentMethod,
    required this.paymentProcessor,
    required this.ppdId,
    required this.reason,
    required this.referenceNumber,
  });

  dynamic byOrderOf;
  dynamic payee;
  dynamic payer;
  dynamic paymentMethod;
  dynamic paymentProcessor;
  dynamic ppdId;
  dynamic reason;
  dynamic referenceNumber;

  factory PaymentMeta.fromJson(Map<String, dynamic> json) => PaymentMeta(
        byOrderOf: json["by_order_of"],
        payee: json["payee"],
        payer: json["payer"],
        paymentMethod: json["payment_method"],
        paymentProcessor: json["payment_processor"],
        ppdId: json["ppd_id"],
        reason: json["reason"],
        referenceNumber: json["reference_number"],
      );

  Map<String, dynamic> toJson() => {
        "by_order_of": byOrderOf,
        "payee": payee,
        "payer": payer,
        "payment_method": paymentMethod,
        "payment_processor": paymentProcessor,
        "ppd_id": ppdId,
        "reason": reason,
        "reference_number": referenceNumber,
      };
}

Institution institutionFromJson(String str) =>
    Institution.fromJson(json.decode(str));

String institutionToJson(Institution data) => json.encode(data.toJson());

class Institution {
  Institution({
    this.institution,
    this.requestId,
  });

  InstitutionClass? institution;
  String? requestId;

  factory Institution.fromJson(Map<String, dynamic> json) => Institution(
        institution: json["institution"] == null
            ? null
            : InstitutionClass.fromJson(json["institution"]),
        requestId: json["request_id"] == null ? null : json["request_id"],
      );

  Map<String, dynamic> toJson() => {
        "institution": institution == null ? null : institution!.toJson(),
        "request_id": requestId == null ? null : requestId,
      };

  @override
  String toString() {
    // TODO: implement toString
    return "this is institution name: $institution.name";
  }
}

class InstitutionClass {
  InstitutionClass({
    required this.countryCodes,
    required this.institutionId,
    required this.name,
    required this.oauth,
    required this.products,
    required this.routingNumbers,
  });

  List<String>? countryCodes;
  String institutionId;
  String? name;
  bool? oauth;
  List<String>? products;
  List<String>? routingNumbers;

  factory InstitutionClass.fromJson(Map<String, dynamic> json) =>
      InstitutionClass(
        countryCodes: json["country_codes"] == null
            ? null
            : List<String>.from(json["country_codes"].map((x) => x)),
        institutionId:
            json["institution_id"] == null ? null : json["institution_id"],
        name: json["name"] == null ? null : json["name"],
        oauth: json["oauth"] == null ? null : json["oauth"],
        products: json["products"] == null
            ? null
            : List<String>.from(json["products"].map((x) => x)),
        routingNumbers: json["routing_numbers"] == null
            ? null
            : List<String>.from(json["routing_numbers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "country_codes": countryCodes == null
            ? null
            : List<dynamic>.from(countryCodes!.map((x) => x)),
        "institution_id": institutionId,
        "name": name == null ? null : name,
        "oauth": oauth == null ? null : oauth,
        "products": products == null
            ? null
            : List<dynamic>.from(products!.map((x) => x)),
        "routing_numbers": routingNumbers == null
            ? null
            : List<dynamic>.from(routingNumbers!.map((x) => x)),
      };
}
