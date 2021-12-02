import 'package:budget_tracker_ui/controller/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum EmailSignInFormType { signIn, register }

class SignInPage extends StatelessWidget {
  SignInPage({
    Key? key,
  }) : super(key: key);

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  static final FirebaseAuth testing = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save It'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    return [
      SizedBox(height: 80.0),
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'email@email.com',
        ),
      ),
      SizedBox(height: 10.0),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
      SizedBox(height: 50.0),
      ElevatedButton(
        child: Text('Sign in'),
        onPressed: () {
          Get.find<AuthController>()
              .signIn(_emailController.text, _passwordController.text);
        },
      ),
      SizedBox(height: 10.0),
      ElevatedButton(
        child: Text('Register'),
        onPressed: () {
          Get.find<AuthController>()
              .register(_emailController.text, _passwordController.text);
        },
      )
    ];
  }
}
