class Account {
  final String account_id;
  Balances balances = Balances(null, null, null, null, null);
  final String mask;
  final String name;
  final String official_name;
  final String subtype;

  Account(this.account_id, this.balances, this.mask, this.name,
      this.official_name, this.subtype);
}

class Balances {
  int? available;
  int? current;
  String? iso_currency_code;
  int? limit;
  String? unofficial_currency_code;
  Balances(this.available, this.current, this.iso_currency_code, this.limit,
      this.unofficial_currency_code);
}
