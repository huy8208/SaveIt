import 'package:budget_tracker_ui/models/notification.dart';
import 'package:budget_tracker_ui/pages/root_app.dart';
import 'package:budget_tracker_ui/pages/sign_in_page.dart';
import 'package:budget_tracker_ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import 'landing_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController dateOfBirth = TextEditingController(text: "04-19-1992");
  bool notiToggle = false;
  bool passChangedBool = false;
  int notifyOptions = 1;

  @override
  void initState() {
    super.initState();
    Notifications.initizlize();
    listenNotification();
  }

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
                  hintText: "Enter Password", border: InputBorder.none),
              controller: password,
            ),
            actions: <Widget>[
              ElevatedButton(
                  //elevation: 5.0,
                  child: Text('Submit'),
                  onPressed: () async {
                    try {
                      await SignInPage.ChangePassword(password.text);
                      Navigator.of(context).pop();
                      passChangedBool = true;
                    } catch (e) {
                      print(e.toString());
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Could not Change Password'),
                              content: Text(e.toString()),
                              actions: [
                                TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                              ],
                            );
                          });
                    }
                    if (passChangedBool) {
                      SnackBar passChange =
                          SnackBar(content: Text('Password Changed'));
                      ScaffoldMessenger.of(context).showSnackBar(passChange);
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
                          await SignInPage.signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => SignInPage(
                                      onSignIn: (User) {},
                                    )),
                            (Route route) => false,
                          );
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
                        width: (size.width - 40) * 0.4,
                        child: Container(
                          child: Stack(
                            children: [
                              RotatedBox(
                                quarterTurns: -2,
                                child: CircularPercentIndicator(
                                    circularStrokeCap: CircularStrokeCap.round,
                                    backgroundColor: grey.withOpacity(0.3),
                                    radius: 110.0,
                                    lineWidth: 6.0,
                                    percent: 0.53,
                                    progressColor: primary),
                              ),
                              Positioned(
                                top: 16,
                                left: 13,
                                child: Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                                          fit: BoxFit.cover)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: (size.width - 40) * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Abbie Wilson",
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
                  '',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                /*TextField(
                  controller: _email,
                  cursorColor: black,
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold, color: black),
                ),*/
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Date of birth",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                TextField(
                  controller: dateOfBirth,
                  cursorColor: black,
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold, color: black),
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
                /*Text(
                  "Change Password",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Color(0xff67727d)),
                ),*/
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
                Text(
                  "Notification",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Color(0xff67727d)),
                ),
                CupertinoSwitch(
                  value: this.notiToggle,
                  onChanged: (bool value) {
                    setState(() {
                      this.notiToggle = value;
                      notifyOptions += 1;
                    });
                    if (notifyOptions % 2 == 0) {
                      Notifications.instantNotify(
                        title: 'Demo',
                        body: 'body',
                        payload: 'payload',
                      );
                    } else {
                      Notifications.cancelNotification();
                      print('cancel');
                    }
                  },
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
