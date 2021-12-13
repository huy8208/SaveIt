import 'dart:convert';

import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/controller/firestore_controller.dart';
import 'package:budget_tracker_ui/db/secure_storage_CRUD.dart';
import 'package:budget_tracker_ui/json/daily_json.dart';
import 'package:budget_tracker_ui/json/day_month.dart';
import 'package:budget_tracker_ui/models/account.dart';
import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:budget_tracker_ui/controller/plaid_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:budget_tracker_ui/db/secure_storage_CRUD.dart';

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
        //backgroundColor: grey.withOpacity(0.05),
        //body: SingleChildScrollView(child: TransactionWidget()),
        body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              /*decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background3.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),*/
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
      //),
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
    return Obx(() =>
        Get.find<PlaidRequestController>().listOfBankAccountWidgets.isEmpty
            ? Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20
                    ),
                    Center(
                      child: Text(
                        "Connect your bank account to \n       see your transactions!",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                      )
                    ),
                  ]
                )
              )
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
  }) : super(key: key);

  final String bankName;
  final Account bankAccount;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BankTitle(nameOfBank: bankName),
        ...(bankAccount.transactions!
            .map((items) => TransactionItem(
                icon: FontAwesomeIcons.addressBook,
                description: items.name!,
                category: items.category[0],
                amount: items.amount,
                date: items.authorizedDate == null
                    ? "Undated"
                    : DateFormat('MM-dd-yyyy').format(items.authorizedDate!)))
            .toList())
      ],
    );
  }
}

class BankTitle extends StatelessWidget {
  const BankTitle({
    Key? key,
    required String this.nameOfBank,
  }) : super(key: key);

  final String nameOfBank;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: const ActionPane(
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: null,
            backgroundColor: Color(0xff174f2a),
            foregroundColor: white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          /*SlidableAction(
            onPressed: null,
            backgroundColor: Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Save',
          ),*/
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Container(
        color: Color(0xffdedede),
        child: ListTile(
          title: Text(
            nameOfBank.toUpperCase(),
            style: TextStyle(
              color: black,
            )),
        ),
      ),
    );
    /*return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 32,
        width: double.infinity,
        child: Align(
          child: Text(nameOfBank),
          alignment: Alignment.centerLeft,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
    );*/
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
