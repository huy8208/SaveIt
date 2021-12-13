import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/controller/firestore_controller.dart';
import 'package:budget_tracker_ui/models/notification.dart';
import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:budget_tracker_ui/utility/snackBarError.dart';
import 'package:budget_tracker_ui/utility/snackBarSuccess.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authController = Get.find<AuthController>();
  String goalText = "...";

  @override
  void initState() {
    super.initState();
    listenNotification();
    // get the Goal Amount on page initialization
    FireStoreController().getUserGoal().then((goalValue) {
      setState(() {
        goalText = goalValue;
      });
    });
  }

  // Password Dialog popup to allow user to change password
  passwordDialog(BuildContext context) {
    TextEditingController password = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Password'),
            content: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Enter New Password", border: InputBorder.none),
              controller: password,
            ),
            actions: <Widget>[
              ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    try {
                      await authController.ChangePassword(password.text);
                      successSnackBar('Password Changed');
                      Navigator.of(context).pop();
                    } catch (e) {
                      errorSnackBar(
                          'Could not Change Password: ' + e.toString());
                    }
                  })
            ],
          );
        });
  }

  // Goal Dialog popup to allow user to change current savings goal
  goalDialog(BuildContext context) {
    TextEditingController newGoalAmount = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Savings Goal'),
            content: TextField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter Goal Amount in Dollars",
                  border: InputBorder.none),
              controller: newGoalAmount,
              maxLength: 8,
            ),
            actions: <Widget>[
              ElevatedButton(
                  //elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () async {
                    try {
                      await FireStoreController.updateUserGoal(
                          newGoalAmount.text);
                      setState(() {
                        goalText = newGoalAmount.text;
                      });
                      successSnackBar('Goal Updated');
                      Navigator.of(context).pop();
                    } catch (e) {
                      errorSnackBar('Could not Change Goal: ' + e.toString());
                    }
                  })
            ],
          );
        });
  }

  void listenNotification() =>
      Notifications.onNotification.stream.listen((clickedNotify));

  void clickedNotify(String? payload) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => (ProfilePage())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Profile",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      IconButton(
                        onPressed: () async {
                          await authController.signOut();
                        },
                        icon: Icon(
                          FontAwesomeIcons.signOutAlt,
                          size: 25,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Overall Savings Goal: ",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$" + goalText,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                Text(
                  '${authController.getCurrentEmail()}',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Color(0xff67727d)),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    goalDialog(context);
                  },
                  child: Text('Update Goal Amount'),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    passwordDialog(context);
                  },
                  child: Text('Change Password'),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black,
                  thickness: 0.5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
