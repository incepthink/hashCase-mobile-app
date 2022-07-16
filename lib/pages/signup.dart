import 'package:flutter/material.dart';
import 'package:hash_case/services/api.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final api = Provider.of<API>(context, listen: false);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _email,
          decoration: const InputDecoration(hintText: 'Username'),
        ),
        TextField(
          cursorHeight: 20,
          controller: _password,
          decoration: const InputDecoration(hintText: 'Password'),
        ),
        TextButton(
          child: const Text('Sign Up'),
          onPressed: () {
            print(_email.text);
            api.SignUp(_email.text, _password.text);
          },
        )
      ],
    ));
  }
}
