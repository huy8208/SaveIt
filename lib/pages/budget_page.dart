//Budget page UI

import 'dart:math';
import 'package:budget_tracker_ui/json/day_month.dart';
import 'package:budget_tracker_ui/controller/budgetController.dart';
import 'package:budget_tracker_ui/models/notification.dart';
import 'package:budget_tracker_ui/pages/sign_in_page.dart';
import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:budget_tracker_ui/pages/create_budget.dart';
import 'package:get/get.dart';
import 'create_budget.dart';
import 'package:budget_tracker_ui/utility/snackBarError.dart';
import 'package:budget_tracker_ui/utility/snackBarSuccess.dart';

// Page for showing the budget list
class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  int activeDay = 3;

  //initalize budget controller
  final budgetController = Get.put(BudgetController());
  TextEditingController currentBudget = TextEditingController();

  @override
  void initState() {
    super.initState();
    listenNotification();
  }

//notification for budget limit reach
  void listenNotification() =>
      Notifications.onNotification.stream.listen((clickedNotify));

  void clickedNotify(String? payload) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => (BudgetPage())));

//convert the amount of budget used to string
  String currentAmountToString(int index1) {
    var price = budgetController.budgets[index1].current_Amount.toString();
    return price;
  }

//calculate the amount of budget used in percentage
  double percentageCalculation(int index1) {
    var percentage = budgetController.budgets[index1].current_Amount /
        budgetController.budgets[index1].budget_TotalAmount;
    return percentage;
  }

  String percentageLabel(int index1) {
    var num1 = budgetController.budgets[index1].current_Amount;
    var num2 = budgetController.budgets[index1].budget_TotalAmount;
    num percentage = (num1 / num2) * 100;
    var temp = percentage.toStringAsFixed(2);
    var percentageLabel = '$temp' + '%';
    return percentageLabel;
  }

//get name of the budget
  String budgetName(int index1) {
    String budgetName = budgetController.budgets[index1].budget_Catagory;
    return budgetName;
  }

//get the amount of the budget
  String totalBudget(int index1) {
    String totalBudget =
        budgetController.budgets[index1].budget_TotalAmount.toString();
    return totalBudget;
  }

//remove budget
  removeBudget(int index1) {
    String budgetId = budgetController.budgets[index1].docID.toString();
    budgetController.deleteBudet(budgetId);
  }

//update the amount of budget used
  updateBudget(int index1, double budget) async {
    String budgetId = budgetController.budgets[index1].docID.toString();
    await budgetController.updateBudet(budgetId, budget);
    budgetCheck(index1);
  }

//check if budget limit reach and send notification when the limit reach
  budgetCheck(index1) {
    String budgetName = budgetController.budgets[index1].budget_Catagory;
    if (budgetController.budgets[index1].current_Amount >=
        budgetController.budgets[index1].budget_TotalAmount) {
      Notifications.instantNotify(
        title: 'Budget Limit Reach!',
        body: 'Budget: ' + '$budgetName' + ' Limit Reach!',
        payload: 'payload',
      );
    } else {
      successSnackBar('Updated');
      Notifications.cancelNotification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
            Scaffold(backgroundColor: grey.withOpacity(0.05), body: getBody()));
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
                BoxShadow(
                  color: grey.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 3,
                  // changes position of shadow
                ),
              ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 9, right: 20, left: 20, bottom: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Budget",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: black),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            (CreateBudgetPage())));
                              },
                              child: Text('+', style: TextStyle(fontSize: 25)),
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xff174f2a),
                                  fixedSize: const Size(20, 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50))),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                  children:
                      List.generate(budgetController.budgets.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: grey.withOpacity(0.01),
                            spreadRadius: 10,
                            blurRadius: 3,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 25, right: 25, bottom: 25, top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  budgetName(index),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color:
                                          Color(0xff67727d).withOpacity(0.6)),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Update Budget Spent'),
                                                      content: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration: InputDecoration(
                                                              hintText:
                                                                  "Current Budget",
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                          controller:
                                                              currentBudget,
                                                          cursorColor:
                                                              const Color(
                                                                  0xff174f2a)),
                                                      actions: <Widget>[
                                                        ElevatedButton(
                                                            //elevation: 5.0,
                                                            child:
                                                                Text('Submit'),
                                                            onPressed:
                                                                () async {
                                                              try {
                                                                await updateBudget(
                                                                    index,
                                                                    double.parse(
                                                                        currentBudget
                                                                            .text));
                                                                successSnackBar(
                                                                    'Updated');
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              } catch (e) {
                                                                errorSnackBar(e
                                                                    .toString());
                                                              }
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                primary: Color(
                                                                    0xff174f2a),
                                                                fixedSize:
                                                                    const Size(
                                                                        80, 15),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50))))
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Text('Edit'),
                                            style: ElevatedButton.styleFrom(
                                                primary: Color(0xff174f2a),
                                                fixedSize: const Size(40, 15),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: IconButton(
                                          onPressed: () {
                                            removeBudget(index);
                                          },
                                          icon: Icon(
                                            FontAwesomeIcons.trashAlt,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "\$" + currentAmountToString(index),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3),
                                    child: Text(
                                      percentageLabel(index),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Color(0xff67727d)
                                              .withOpacity(0.6)),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Text(
                                  "\$" + totalBudget(index),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color:
                                          Color(0xff67727d).withOpacity(0.6)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Stack(
                            children: [
                              Container(
                                width: (size.width - 40),
                                height: 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xff67727d).withOpacity(0.1)),
                              ),
                              Container(
                                width: (size.width - 40) *
                                    percentageCalculation(index),
                                height: 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xff30a156)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })),
            )
          ],
        ),
      ),
    );
  }
}
