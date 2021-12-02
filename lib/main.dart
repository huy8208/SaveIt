import 'package:budget_tracker_ui/pages/landing_page.dart';
import 'package:budget_tracker_ui/pages/root_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'models/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Notifications.initizlize();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: LandingPage(),
    // home was initially 'RootApp()'
  ));
}
