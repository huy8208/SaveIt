import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum EmailSignInFormType { signIn, register }

class SignInPage extends StatelessWidget {
  SignInPage({Key? key, required this.onSignIn}) : super(key: key);

  final void Function(User) onSignIn;
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  static final userCredentials = FirebaseAuth.instance;

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
          signIn(_emailController.text, _passwordController.text, context);
        },
      ),
      SizedBox(height: 10.0),
      ElevatedButton(
        child: Text('Register'),
        onPressed: () {
          register(_emailController.text, _passwordController.text, context);
        },
      )
    ];
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      final userCredentials = await FirebaseAuth.instance.signInWithCredential(
          EmailAuthProvider.credential(email: email, password: password));
      onSignIn(userCredentials.user!);
    } catch (e) {
      print(e.toString());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Could not sign in'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> register(
      String email, String password, BuildContext context) async {
    try {
      final userCredentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      onSignIn(userCredentials.user!);
    } catch (e) {
      print(e.toString());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Could not register account'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          });
    }
  }
}
