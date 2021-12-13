import 'dart:io';

import 'package:budget_tracker_ui/bindings/global_bindings.dart';
import 'package:budget_tracker_ui/pages/landing_page.dart';
import 'package:budget_tracker_ui/pages/root_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'models/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Notifications.initizlize();
  GlobalBinding().dependencies();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: LandingPage(),
    title: "SaveIt",
    theme: ThemeData(
        appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
      statusBarIconBrightness:
          Platform.isIOS ? Brightness.light : Brightness.dark,
    ))),
    // home was initially 'RootApp()'
  ));
}
