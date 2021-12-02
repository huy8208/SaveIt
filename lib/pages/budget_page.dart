import 'dart:math';

import 'package:budget_tracker_ui/json/budget_json.dart';
import 'package:budget_tracker_ui/json/day_month.dart';
import 'package:budget_tracker_ui/models/budgetController.dart';
import 'package:budget_tracker_ui/pages/sign_in_page.dart';
import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:budget_tracker_ui/pages/create_budget.dart';
import 'package:get/get.dart';
import 'create_budget.dart';

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  int activeDay = 3;
  final List color = [red, blue, green];
  final budgetController = Get.put(BudgetController());

  @override
  void initState() {
    super.initState();
  }

  String currentAmountToString(int index1) {
    var price = budgetController.budgets[index1].current_Amount.toString();
    return price;
  }

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

  String budgetName(int index1) {
    String budgetName = budgetController.budgets[index1].budget_Catagory;
    return budgetName;
  }

  String totalBudget(int index1) {
    String totalBudget =
        budgetController.budgets[index1].budget_TotalAmount.toString();
    return totalBudget;
  }

  Color randomColor() {
    var random = new Random();
    var randomC = color[random.nextInt(color.length)];
    return randomC;
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
              decoration: BoxDecoration(color: white, boxShadow: [
                BoxShadow(
                  color: grey.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 3,
                  // changes position of shadow
                ),
              ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 60, right: 20, left: 20, bottom: 25),
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
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            (CreateBudgetPage())));
                              },
                              icon: Icon(
                                Icons.add,
                                size: 25,
                              ),
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
                          Text(
                            budgetName(index),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d).withOpacity(0.6)),
                          ),
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
                                    color: randomColor()),
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
