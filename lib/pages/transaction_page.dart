import 'package:budget_tracker_ui/json/daily_json.dart';
import 'package:budget_tracker_ui/json/day_month.dart';
import 'package:budget_tracker_ui/models/account.dart';
import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:budget_tracker_ui/plaid/request.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int activeDay = 3;
  bool hasBankAccount = true;
  late PlaidRequestController plaidrequestcontroller;

  @override
  void initState() {
    // Initialize Plaid Controller.
    plaidrequestcontroller = Get.put(PlaidRequestController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: grey.withOpacity(0.05),
        body: SingleChildScrollView(child: TransactionWidget()),
      ),
    );
  }

//   Widget getBody() {
//     var size = MediaQuery.of(context).size;
//     return SingleChildScrollView(child: TransactionWidget());
//   }
}

class TransactionWidget extends StatefulWidget {
  const TransactionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  late Account bankAccount;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => Get.find<PlaidRequestController>().listOfBankAccounts.isEmpty
            ? Center(child: Text("Please add bank account"))
            : Column(
                children: Get.find<PlaidRequestController>().listOfBankAccounts,
              ));
  }
}

class TransactionsWithBankTitle extends StatelessWidget {
  const TransactionsWithBankTitle({
    Key? key,
    required this.bankAccount,
  }) : super(key: key);

  final Account bankAccount;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BankTitle(
            nameOfBank: Get.find<PlaidRequestController>().bankName.value),
        ...(bankAccount.transactions!
            .map((items) => TransactionItem(
                icon: FontAwesomeIcons.addressBook,
                description: items.name!,
                category: items.category[0],
                amount: items.amount,
                date: items.authorizedDate == null
                    ? ""
                    : DateFormat('MM-dd-yyyy').format(items.authorizedDate!)))
            .toList())
      ],
    );
  }
}

class BankTitle extends StatelessWidget {
  BankTitle({
    Key? key,
    required String? nameOfBank,
  }) : super(key: key);

  final nameOfBank = null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 32,
        width: double.infinity,
        child: Align(
          child: nameOfBank == null ? Text("") : Text("$nameOfBank"),
          alignment: Alignment.centerLeft,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.icon,
    required this.description,
    required this.category,
    required this.amount,
    required this.date,
  }) : super(key: key);

  final IconData icon;
  final String description;
  final String category;
  final double amount;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 55,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(flex: 1, child: Icon(icon)),
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  category,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Spacer(),
          Flexible(
            flex: 2,
            child: FittedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("\$" + amount.toString()),
                  Text(date),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
