import 'package:budget_tracker_ui/json/daily_json.dart';
import 'package:budget_tracker_ui/json/day_month.dart';
import 'package:budget_tracker_ui/models/account.dart';
import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:budget_tracker_ui/plaid/request.dart';
import 'package:get/get.dart';
import 'package:budget_tracker_ui/models/transaction.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int activeDay = 3;
  bool hasBankAccount = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: hasBankAccount
            ? TransactionWidget()
            : Container(
                child:
                    Text("Please authenticate your bank accounts with plaid."),
                color: Colors.blue[50],
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
  late PlaidRequestController plaidrequestcontroller;

  @override
  void initState() {
    super.initState();
    plaidrequestcontroller = Get.put(PlaidRequestController());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 32,
            width: double.infinity,
            child: Align(
              child: Text("Bank of America"),
              alignment: Alignment.centerLeft,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
          ),
        ),
        Obx(
          () => Column(
              children: plaidrequestcontroller.transaction
                  .map((items) => TransactionItem(
                      icon: items.icon,
                      description: items.description,
                      category: items.category,
                      price: items.price,
                      date: items.date))
                  .toList()),
        ),
        ElevatedButton(
            onPressed: () {
              plaidrequestcontroller.transaction
                  .remove(plaidrequestcontroller.transaction.first);
            },
            child: Text("PRESS ME!"))
      ],
    );
  }
}

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.icon,
    required this.description,
    required this.category,
    required this.price,
    required this.date,
  }) : super(key: key);

  final IconData icon;
  final String description;
  final String category;
  final String price;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 55,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(description),
              Text(category),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(price),
              Text(date),
            ],
          ),
        ],
      ),
    );
  }
}
