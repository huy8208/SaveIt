//Transaction page UI

import 'package:budget_tracker_ui/controller/firestore_controller.dart';
import 'package:budget_tracker_ui/models/account.dart';
import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:budget_tracker_ui/controller/plaid_controller.dart';
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
  late FireStoreController fireStoreController;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 65, right: 20, left: 20, bottom: 20),
                          child: Text(
                            "Transactions",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: black),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: TransactionWidget(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
  Widget build(BuildContext context) {
    print(Get.find<PlaidRequestController>().listOfBankAccounts);
    return Obx(() =>
        Get.find<PlaidRequestController>().listOfBankAccountWidgets.isEmpty
            ? Center(
                child: Column(children: [
                SizedBox(height: 20),
                Center(
                    child: Text(
                  "Connect your bank account to \n       see your transactions!",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                )),
              ]))
            : Column(
                children:
                    Get.find<PlaidRequestController>().listOfBankAccountWidgets,
              ));
  }
}

class TransactionsWithBankTitle extends StatelessWidget {
  const TransactionsWithBankTitle({
    Key? key,
    required this.bankName,
    required this.bankAccount,
    //required this.accessToken,
  }) : super(key: key);

  final String bankName;
  final Account bankAccount;
  //final String accessToken;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BankTitle(nameOfBank: bankName), //, accessToken: accessToken),
        ...(bankAccount.transactions!
            .map((items) => TransactionItem(
                icon: FontAwesomeIcons.addressBook,
                description: items.name!,
                category: items.category[0],
                amount: items.amount,
                date: items.date == null
                    ? "Undated"
                    : DateFormat('MM-dd-yyyy').format(items.date!)))
            .toList())
      ],
    );
  }
}

class BankTitle extends StatelessWidget {
  const BankTitle({
    Key? key,
    required String this.nameOfBank,
    //required String this.accessToken,
  }) : super(key: key);

  final String nameOfBank;
  //final String accessToken;

  /*remove() {
    FireStoreController.deletePlaidAccessToken(accessToken);
  }*/

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed:
                removeSelectedBank, //FireStoreController.deletePlaidAccessToken(accessToken),
            backgroundColor: Color(0xff174f2a),
            foregroundColor: white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Container(
        color: Color(0xffdedede),
        child: ListTile(
          title: Text(nameOfBank.toUpperCase(),
              style: TextStyle(
                color: black,
              )),
        ),
      ),
    );
  }

  void removeSelectedBank(BuildContext buildContext) {
    Get.find<PlaidRequestController>()
        .listOfBankAccountWidgets
        .removeWhere((element) => element.key == ObjectKey(nameOfBank));
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
        boxShadow: [
          BoxShadow(
            color: grey.withOpacity(0.1),
            spreadRadius: 10,
            blurRadius: 5,
            // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text("\$" + amount.toString(),
                      style: TextStyle(fontSize: 12)),
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
