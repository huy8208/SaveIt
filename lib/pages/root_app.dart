import 'package:budget_tracker_ui/pages/budget_page.dart';
import 'package:budget_tracker_ui/pages/add_bank_account.dart';
import 'package:budget_tracker_ui/pages/create_budget.dart';
import 'package:budget_tracker_ui/pages/transaction_page.dart';
import 'package:budget_tracker_ui/pages/profile_page.dart';
import 'package:budget_tracker_ui/pages/home_page.dart';
import 'package:budget_tracker_ui/models/notification.dart';
import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:budget_tracker_ui/widget/spendingChart.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  List<Widget> pages = [
    HomePage(),
    TransactionPage(),
    BudgetPage(),
    ProfilePage(),
    AddBankAccountPage(),
    CreateBudgetPage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.home)),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.moneyBillAlt)),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.plusCircle)),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.wallet)),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userAlt)),
        ],
        activeColor: const Color(0xff174f2a),
        backgroundColor: white,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: HomePage(),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: TransactionPage(),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: AddBankAccountPage(),
              );
            });
          case 3:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: BudgetPage(),
              );
            });
          case 4:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ProfilePage(),
              );
            });
          default:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: HomePage(),
              );
            });
        }
      },
    );
  }
}
   

/*
import 'package:budget_tracker_ui/pages/budget_page.dart';
import 'package:budget_tracker_ui/pages/add_bank_account.dart';
import 'package:budget_tracker_ui/pages/transaction_page.dart';
import 'package:budget_tracker_ui/pages/profile_page.dart';
import 'package:budget_tracker_ui/pages/home_page.dart';
import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  List<Widget> pages = [
    HomePage(),
    TransactionPage(),
    BudgetPage(),
    ProfilePage(),
    AddBankAccountPage()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              selectedTab(4);
            },
            child: Icon(
              Icons.add,
              size: 25,
            ),
            backgroundColor: Colors.pink
            //params
            ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      FontAwesomeIcons.home,
      FontAwesomeIcons.moneyBillAlt,
      FontAwesomeIcons.wallet,
      FontAwesomeIcons.userAlt
    ];

    return AnimatedBottomNavigationBar(
      activeColor: primary,
      splashColor: secondary,
      inactiveColor: Colors.black.withOpacity(0.5),
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
*/