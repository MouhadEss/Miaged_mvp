import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miaged_mvp/list.dart';
import 'package:miaged_mvp/panier.dart';
import 'package:miaged_mvp/profil.dart';

class NavigateurBar extends StatefulWidget {
  @override
  _NavigateurbarState createState() => _NavigateurbarState();
}

class _NavigateurbarState extends State<NavigateurBar> {
  int idnav = 0;
  User u = FirebaseAuth.instance.currentUser;
  List<Vetement> vs = List<Vetement>();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: navItems,
        currentIndex: idnav,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped);
  }

  void _onItemTapped(int index) {
    setState(() {
      idnav = index;
      if (idnav == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ListVetements()));
      } else if (idnav == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Panier(vs)));
      } else if (idnav == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profil(u)));
      }
    });
  }

  final navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag_outlined),
      label: 'Acheter',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_shopping_cart),
      label: 'Panier',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_box_rounded),
      label: 'Profil',
    ),
  ];
}
