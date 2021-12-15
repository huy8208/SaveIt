//Add Bank Account UI

import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:budget_tracker_ui/controller/plaid_controller.dart';
import 'package:budget_tracker_ui/widget/accountCards.dart';
import 'package:get/get.dart';

// Page for adding a bank account
class AddBankAccountPage extends StatefulWidget {
  @override
  _AddBankAccountPageState createState() => _AddBankAccountPageState();
}

// Page is stateful and accesses a PlaidRequestController
class _AddBankAccountPageState extends State<AddBankAccountPage> {
  late PlaidRequestController plaidrequestcontroller;
  @override
  void initState() {
    super.initState();
    plaidrequestcontroller = Get.put(PlaidRequestController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  // Page body consits of a button to start Plaid bank linking process
  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 55, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add New Bank",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: plaidrequestcontroller.openPlaidOAth,
                            child: Text('+', style: TextStyle(fontSize: 25)),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff174f2a),
                                fixedSize: const Size(20, 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                          ),
                        ], //Need to re-check
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
              padding:
                  const EdgeInsets.only(top: 20, bottom: 15, left: 5, right: 5),
              child: AccountCard()),
        ],
      ),
    );
  }
}
