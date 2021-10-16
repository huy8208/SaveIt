import 'package:budget_tracker_ui/json/daily_json.dart';
import 'package:budget_tracker_ui/json/day_month.dart';
import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  int activeDay = 3;
  bool hasBankAccount = true;

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
        child: Column(
          children: [
            // Container(
            //   decoration: BoxDecoration(color: white, boxShadow: [
            //     BoxShadow(
            //       color: grey.withOpacity(0.01),
            //       spreadRadius: 10,
            //       blurRadius: 3,
            //       // changes position of shadow
            //     ),
            //   ]),
            //   child: Padding(
            //     padding: const EdgeInsets.only(
            //         top: 60, right: 20, left: 20, bottom: 25),
            //     child: Column(
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               "Transactions",
            //               style: TextStyle(
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.bold,
            //                   color: black),
            //             ),
            //             Icon(FontAwesomeIcons.search)
            //           ],
            //         ),
            //         SizedBox(
            //           height: 25,
            //         ),
            //         Row(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: List.generate(days.length, (index) {
            //               return GestureDetector(
            //                 onTap: () {
            //                   setState(() {
            //                     activeDay = index;
            //                   });
            //                 },
            //                 child: Container(
            //                   width: (MediaQuery.of(context).size.width - 40) / 7,
            //                   child: Column(
            //                     children: [
            //                       Text(
            //                         days[index]['label'],
            //                         style: TextStyle(fontSize: 10),
            //                       ),
            //                       SizedBox(
            //                         height: 10,
            //                       ),
            //                       Container(
            //                         width: 30,
            //                         height: 30,
            //                         decoration: BoxDecoration(
            //                             color: activeDay == index
            //                                 ? primary
            //                                 : Colors.transparent,
            //                             shape: BoxShape.circle,
            //                             border: Border.all(
            //                                 color: activeDay == index
            //                                     ? primary
            //                                     : black.withOpacity(0.1))),
            //                         child: Center(
            //                           child: Text(
            //                             days[index]['day'],
            //                             style: TextStyle(
            //                                 fontSize: 10,
            //                                 fontWeight: FontWeight.w600,
            //                                 color: activeDay == index
            //                                     ? white
            //                                     : black),
            //                           ),
            //                         ),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               );
            //             }))
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20),
            //   child: Column(
            //       children: List.generate(daily.length, (index) {
            //     return Column(
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Container(
            //               width: (size.width - 40) * 0.7,
            //               child: Row(
            //                 children: [
            //                   Container(
            //                     width: 50,
            //                     height: 50,
            //                     decoration: BoxDecoration(
            //                       shape: BoxShape.circle,
            //                       color: grey.withOpacity(0.1),
            //                     ),
            //                     child: Center(
            //                       child: Image.asset(
            //                         daily[index]['icon'],
            //                         width: 30,
            //                         height: 30,
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(width: 15),
            //                   Container(
            //                     width: (size.width - 90) * 0.5,
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.center,
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text(
            //                           daily[index]['name'],
            //                           style: TextStyle(
            //                               fontSize: 15,
            //                               color: black,
            //                               fontWeight: FontWeight.w500),
            //                           overflow: TextOverflow.ellipsis,
            //                         ),
            //                         SizedBox(height: 5),
            //                         Text(
            //                           daily[index]['date'],
            //                           style: TextStyle(
            //                               fontSize: 12,
            //                               color: black.withOpacity(0.5),
            //                               fontWeight: FontWeight.w400),
            //                           overflow: TextOverflow.ellipsis,
            //                         ),
            //                       ],
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //             Container(
            //               width: (size.width - 40) * 0.3,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.end,
            //                 children: [
            //                   Text(
            //                     daily[index]['price'],
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.w600,
            //                         fontSize: 15,
            //                         color: Colors.green),
            //                   ),
            //                 ],
            //               ),
            //             )
            //           ],
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 65, top: 8),
            //           child: Divider(
            //             thickness: 0.8,
            //           ),
            //         )
            //       ],
            //     );
            //   })),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20),
            //   child: Row(
            //     children: [
            //       Spacer(),
            //       Padding(
            //         padding: const EdgeInsets.only(right: 80),
            //         child: Text(
            //           "Total",
            //           style: TextStyle(
            //               fontSize: 16,
            //               color: black.withOpacity(0.4),
            //               fontWeight: FontWeight.w600),
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //       ),
            //       Spacer(),
            //       Padding(
            //         padding: const EdgeInsets.only(top: 5),
            //         child: Text(
            //           "\$1780.00",
            //           style: TextStyle(
            //               fontSize: 20,
            //               color: black,
            //               fontWeight: FontWeight.bold),
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            hasBankAccount
                ? TransactionWidget()
                : Container(
                    child: Text(
                        "Please authenticate your bank accounts with plaid."),
                    color: Colors.blue[50],
                  )
          ],
        ),
      ),
    );
  }
}

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    Key? key,
  }) : super(key: key);

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
        TransactionItem(
          price: "\$300",
          category: 'Travel',
          date: '06 Sun',
          icon: FontAwesomeIcons.plane,
          description: 'Haiwaii',
        ),
        TransactionItem(
          price: "\$300",
          category: 'Travel',
          date: '06 Sun',
          icon: FontAwesomeIcons.plane,
          description: 'Haiwaii',
        ),
        TransactionItem(
          price: "\$300",
          category: 'Travel',
          date: '06 Sun',
          icon: FontAwesomeIcons.plane,
          description: 'Haiwaii',
        )
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
