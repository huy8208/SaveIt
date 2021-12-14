import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:budget_tracker_ui/pages/root_app.dart';
import 'package:budget_tracker_ui/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Landing page is the first page shown to user
class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

// The landing page listens to AuthController
// If a user is signed in, RootApp page will be shown
// If a user is not signed in, SignInPage will be shown
class _LandingPageState extends State<LandingPage> {
  final AuthController authController = Get.find<AuthController>();

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
