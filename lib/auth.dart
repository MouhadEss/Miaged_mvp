import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miaged_mvp/list.dart';
import 'package:miaged_mvp/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class SeConnecter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miaged Auth',
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  Login({Key key, this.titre = ''}) : super(key: key);

  final String titre;

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return ListVetements();
    }
    return SignInPage();
  }
}
