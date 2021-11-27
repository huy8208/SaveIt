import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum EmailSignInFormType { signIn, register }

class SignInPage extends StatelessWidget {
  SignInPage({Key? key, required this.onSignIn}) : super(key: key);

  final void Function(User) onSignIn;

  Future<void> signInAnonymously() async {
    try {
      final userCredentials = await FirebaseAuth.instance.signInAnonymously();
      onSignIn(userCredentials.user!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      final userCredentials = await FirebaseAuth.instance.signInWithCredential(
          EmailAuthProvider.credential(email: email, password: password));
      onSignIn(userCredentials.user!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> register(String email, String password) async {
    try {
      final userCredentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      onSignIn(userCredentials.user!);
    } catch (e) {
      print(e.toString());
    }
  }

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  // void _submit() {
  //   print(
  //       'email: ${_emailController.text}, password: ${_passwordController.text}');
  // }

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
          // EmailSignInForm(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(),
            ),
          ),
          ElevatedButton(
            child: Text('Test Sign in'),
            onPressed: () {
              signInAnonymously();
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChildren() {
    return [
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
      SizedBox(height: 20.0),
      ElevatedButton(
        child: Text('Sign in'),
        onPressed: () {
          signIn(_emailController.text, _passwordController.text);
        },
      ),
      ElevatedButton(
        child: Text('Register'),
        onPressed: () {
          register(_emailController.text, _passwordController.text);
        },
      )
    ];
  }
}
