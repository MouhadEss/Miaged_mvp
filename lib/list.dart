import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miaged_mvp/auth.dart';
import 'package:miaged_mvp/detail.dart';
import 'package:miaged_mvp/navigateur.dart';
import 'package:miaged_mvp/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ListVetements extends StatefulWidget {
  @override
  ListVetementsState createState() => ListVetementsState();
}

class ListVetementsState extends State<ListVetements> {
  List<Vetement> vs = List<Vetement>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('List des vêtements disponnible'),
        actions: [
          RaisedButton(
            color: Colors.green,
            onPressed: () {
              context.read<AuthenticationService>().signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Icon(Icons.logout, color: Colors.black),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("vetements")
                  .snapshots(),
              builder: (context, dataSnapshot) {
                return !dataSnapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 1,
                        staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          Vetement vetement = Vetement.fromJson(
                              dataSnapshot.data.docs.first.get(index));
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Detail(v: vetement)));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Container(
                                height: 120.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: [
                                    Image.network(
                                      vetement.image,
                                      width: 90.0,
                                      height: 90.0,
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    vetement.titre,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15.0),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    vetement.taille,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13.0),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Container(),
                                          ),
                                          Align(
                                              alignment: Alignment.center,
                                              child: (!vs.contains(vetement))
                                                  ? IconButton(
                                                      icon: Icon(
                                                        Icons.add_shopping_cart,
                                                        color: Colors.green,
                                                      ),
                                                      onPressed: () {
                                                        vs.add(vetement);
                                                      },
                                                    )
                                                  : IconButton(
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red[900],
                                                      ),
                                                      onPressed: () {
                                                        vs.remove(vetement);
                                                      },
                                                    ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: dataSnapshot.data.docs.length,
                      );
              })
        ],
      ),
      bottomNavigationBar: NavigateurBar(),
    );
  }
}

class Vetement {
  int id;
  String titre;
  String image;
  int prix;
  String taille;
  String marque;

  Vetement(
      {this.id, this.titre, this.image, this.prix, this.taille, this.marque});

  Vetement.fromJson(Map<String, dynamic> json) {
    titre = json['titre'];
    image = json['image'];
    prix = json['prix'];
    taille = json['taille'];
    marque = json['marque'];
  }
}
