//Sign-in page UI

import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Page for user sign in and registration
class SignInPage extends StatelessWidget {
  SignInPage({
    Key? key,
  }) : super(key: key);

  // Text controllers for email and password
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff174f2a),
          title: Text(
            'Save It',
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(context),
      ),
    );
  }

  // Widget list consisting of username and password field and login/register buttons
  List<Widget> _buildChildren(BuildContext context) {
    return [
      Container(
        color: const Color(0xff174f2a),
        width: double.infinity,
        height: 60,
        child: Center(
          child: Text("Your All-in-One Financial App",
              style: TextStyle(
                color: const Color(0xffbfbfbf),
                fontSize: 14,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 70.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: const Color(0xff174f2a),
                ),
                hintText: 'email@site.com',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xff174f2a))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: const Color(0xff174f2a), width: 1.5)),
              ),
              cursorColor: const Color(0xff174f2a),
            ),
            SizedBox(height: 10.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: const Color(0xff174f2a),
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xff174f2a))),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: const Color(0xff174f2a), width: 1.5)),
              ),
              cursorColor: const Color(0xff174f2a),
              obscureText: true,
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              child: Text('Sign in'),
              onPressed: () {
                Get.find<AuthController>()
                    .signIn(_emailController.text, _passwordController.text);
              },
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff174f2a),
                  fixedSize: const Size(120, 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              child: Text('Register'),
              onPressed: () {
                Get.find<AuthController>()
                    .register(_emailController.text, _passwordController.text);
              },
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff174f2a),
                  fixedSize: const Size(120, 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ],
        ),
      ),
    ];
  }
}
