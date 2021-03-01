import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miaged_mvp/services/auth_service.dart';

import 'list.dart';

class Sinscrire extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('MIAGED'),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
              ),
              RaisedButton(
                onPressed: () {
                  // ignore: unnecessary_statements
                  (context) => context.read<AuthenticationService>().signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ListVetements()));
                },
                child: Text("S'inscrire"),
              )
            ],
          ),
        ));
  }
}
