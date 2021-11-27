import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'email_sign_in_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.onSignIn}) : super(key: key);

  final void Function(User) onSignIn;
  Future<void> _signInAnonymously() async {
    try {
      final userCredentials = await FirebaseAuth.instance.signInAnonymously();
      onSignIn(userCredentials.user!);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save It'),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: Card(
      //     child: EmailSignInForm(),
      //   ),
      // ),
      // body: ElevatedButton(
      //   child: Text('Test Sign in'),
      //   onPressed: () {
      //     _signInAnonymously();
      //   },
      // ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            EmailSignInForm(),
            ElevatedButton(
              child: Text('Test Sign in'),
              onPressed: () {
                _signInAnonymously();
              },
            ),
          ]),
    );
  }
}
