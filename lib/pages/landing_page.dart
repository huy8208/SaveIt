import 'package:budget_tracker_ui/globals/userDetails.dart';
import 'package:budget_tracker_ui/pages/root_app.dart';
import 'package:budget_tracker_ui/pages/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User? _user;

  void _updateUser(User user) {
    print('User id: ${user.uid}');
    UserDetails.uid = user.uid;
    print('user id again: ${UserDetails.uid}');
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(
        onSignIn: (user) => _updateUser(user),
      );
    }

    return RootApp();
  }
}
