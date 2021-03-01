import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Profil extends StatefulWidget {
  Profil(this.user);
  User user = FirebaseAuth.instance.currentUser;

  @override
  ProfilState createState() => ProfilState();
}

class ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Text("profil");
  }
}
