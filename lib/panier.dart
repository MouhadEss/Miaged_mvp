import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miaged_mvp/list.dart';

class Panier extends StatefulWidget {
  final List<Vetement> panier;

  Panier(this.panier);

  @override
  PanierState createState() => PanierState();
}

class PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    List<Vetement> panier;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Your Cart',
            style: TextStyle(color: Colors.green[900]),
          ),
        ),
        body: ListView.builder(
            itemCount: panier.length,
            itemBuilder: (context, index) {
              var v = widget.panier[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                child: Card(
                  elevation: 4.0,
                  child: ListTile(
                    leading: Image.network(v.image),
                    title: Text(v.titre),
                    trailing: GestureDetector(
                        child: Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                        onTap: () {
                          setState(() {
                            panier.remove(v);
                          });
                        }),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
