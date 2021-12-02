import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/globals/userDetails.dart';
import 'package:budget_tracker_ui/pages/root_app.dart';
import 'package:budget_tracker_ui/pages/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (authController.isAuthenticated.value == false) {
        return SignInPage();
      } else {
        return RootApp();
      }
    });
  }
}
