import 'package:flutter/material.dart';
import 'package:hash_case/pages/home.dart';
import 'package:hash_case/services/api.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignUpState();
}

TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();

class _SignUpState extends State<SignIn> {
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
          child: const Text('Sign In'),
          onPressed: () async {
            try {
              await api.SignIN(_email.text, _password.text);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => const HomePage())));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.toString()),
                ),
              );
            }
          },
        )
      ],
    ));
  }
}
