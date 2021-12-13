import 'package:budget_tracker_ui/controller/data_controller.dart';
import 'package:budget_tracker_ui/json/day_month.dart';
import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:budget_tracker_ui/widget/spendingChart.dart';
import 'package:budget_tracker_ui/widget/accountCards.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeDay = 3;

  bool showAvg = false;

  final NumberFormat formatter = NumberFormat('#,###.00');
  // formatter.minimumFractionDigits = 2

  DataController dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    RxList expenses = [
      {
        "icon": Icons.arrow_back,
        "color": const Color(0xff174f2a),
        "label": "Income",
        "cost": formatter.format(dataController.total.value)
      },
      {
        "icon": Icons.arrow_forward,
        "color": const Color(0xff174f2a),
        "label": "Expense",
        "cost": "555555"
      }
    ].obs;
    return Scaffold(
      body: SingleChildScrollView(
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
                  top: 60, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      //Icon(FontAwesomeIcons.search) //need to recheck
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "This month spend",
                        style: TextStyle(
                          fontSize: 12,
                          color: grey),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "\$1200.11",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w500,
                          color: black),
                      )
                    ]
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  /*boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]*/),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: 320,
                  child: SpendingChart(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
              spacing: 20,
              children: List.generate(expenses.length, (index) {
                return Container(
                  width: (size.width - 60) / 2,
                  height: 170,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.3),
                          //spreadRadius: 10,
                          blurRadius: 10,
                          // changes position of shadow
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: expenses[index]['color']),
                          child: Center(
                              child: Icon(
                            expenses[index]['icon'],
                            color: white,
                          )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              expenses[index]['label'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xff67727d)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Obx(
                              () => Text(
                                expenses[index]['cost'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })),
              SizedBox(
                height: 25,
              ),
              Padding (
            padding: const EdgeInsets.only(left: 10, right: 10),//all(0),
            child: Container(
              width: double.infinity, //400
              //height: double.infinity, //175
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  /*boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.5),
                      //spreadRadius: 5,
                      blurRadius: 20,
                      // changes position of shadow
                    ),
                  ]*/),
            //adds accounts
              child: AccountCard(),
            ),
          ), 
        ],
      ),
    ),
    );
  }
}
