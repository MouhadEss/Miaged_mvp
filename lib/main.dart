import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miaged_mvp/auth.dart';
import 'package:miaged_mvp/sinscrire.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> fbApp = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Miaged Auth',
      home: FutureBuilder(
          future: fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(
                  "une erreur initialization Firebase ${snapshot.error.toString()}");
              return Text("erreur initialization Firebase");
            } else if (snapshot.hasData) {
              return Accueil();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class Accueil extends StatefulWidget {
  Accueil({Key key, this.titre = ''}) : super(key: key);

  final String titre;

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('MIAGED'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "MIAGED votre Application de vente d'occasion",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              elevation: 0,
              height: 30,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (conext) => Sinscrire()));
              },
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Je m inscris',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              textColor: Colors.white,
            ),
            MaterialButton(
              elevation: 0,
              height: 30,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (conext) => SeConnecter()));
              },
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Je me connecte',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
