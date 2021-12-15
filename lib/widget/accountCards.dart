import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:budget_tracker_ui/models/account.dart';
import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/controller/firestore_controller.dart';
import 'package:budget_tracker_ui/controller/plaid_controller.dart';
import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AccountCard extends StatefulWidget {
  const AccountCard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AccountCardState();
}

class AccountCardState extends State<AccountCard> {
  late PlaidRequestController plaidRequestController;
  late FireStoreController fireStoreController;
  var access_token;
  var bankName;
  var transactions;
  var bankAccount;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        Get.find<PlaidRequestController>().listOfAccountsWithinBank.isEmpty
            ? Center(child: Text(""))
            : Obx(
                () => Column(
                  children: Get.find<PlaidRequestController>()
                      .listOfAccountsWithinBank,
                ),
              ));
  }
}

class FinalAccountCards extends StatelessWidget {
  const FinalAccountCards({
    Key? key,
    required this.bankAccount,
    required this.bankName,
  }) : super(key: key);

  final Account bankAccount;
  final String bankName;

  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      ...(bankAccount.accounts.sublist(0, 4).map((items) =>
          AccountNameAndBalance(
              icon: items.name?.contains("Card") ?? false
                  ? Icons.credit_card_rounded
                  : Icons.account_balance_rounded,
              nameOfAccount: items.name?.replaceAll("Plaid", bankName) ?? "",
              balance: items.balances.current ?? 0)))
    ]);
  }
}

class AccountNameAndBalance extends StatelessWidget {
  const AccountNameAndBalance({
    Key? key,
    required this.icon,
    required this.nameOfAccount,
    required this.balance,
  }) : super(key: key);

  final IconData icon;
  final String nameOfAccount;
  final double balance;

  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.3),
                blurRadius: 10,
              )
            ],
          ),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: white,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nameOfAccount,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Color(0xff67727d)),
                      ),
                      SizedBox(
                        height: 59,
                        width: 400,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Icon(
                                icon,
                                size: 50,
                                color: Color(0xFF30343b),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 150),
                              child: Text(
                                "\$" + balance.toString() + "0",
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
