// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:pick_poker/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  var crediti;
  late UserCredential utente;
  String foto_profilo = "";

  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        setState(() {
          foto_profilo = user.photoURL!;
        });
      }
    });
  }

  void getCrediti(utente) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('utenti/${utente.uid}/').get();

    if (snapshot.exists) {
      crediti = snapshot.children.first.value;
    } else {
      await ref.set({
        "utenti": {
          utente.uid: {"crediti": 100}
        }
      });

      crediti = 100;
    }

    if (crediti <= 0) crediti = 10;

    if (mounted) {
      Navigator.pushNamed(context, "/punta",
          arguments: {"credito": crediti, "utente": utente.uid});
    }
  }

  void checkLogin() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Navigator.pushNamed(context, "/login", arguments: {"provider": ""});
      } else {
        getCrediti(user);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/Campo.jpg"), fit: BoxFit.cover),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/Carte/AS.png",
                      height: MediaQuery.of(context).size.height * 0.14,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xff810000),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                          border:
                              Border.all(color: Color(0xffFFDD00), width: 3)),
                      padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: Text(
                        "PickPoker",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xffffDD00),
                            fontSize: 45,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                RawMaterialButton(
                  onPressed: () {
                    checkLogin();
                  },
                  fillColor: Color(0xff810000),
                  shape: CircleBorder(
                      side: BorderSide(color: Color(0xffffDD00), width: 3)),
                  padding: EdgeInsets.all(20),
                  child: Icon(
                    Icons.play_arrow,
                    color: Color(0xffffDD00),
                    size: 120,
                  ),
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                RawMaterialButton(
                  onPressed: () {
                    //Navigator.pushNamed(context, "/info");
                  },
                  fillColor: Color(0xff810000),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      side: BorderSide(color: Color(0xffffDD00), width: 2)),
                  child: Text(
                    "How to play?",
                    style: TextStyle(
                        color: Color(0xffffDD00),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Flex(
                  mainAxisAlignment: MainAxisAlignment.end,
                  direction: Axis.horizontal,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,
                          MediaQuery.of(context).size.height * 0.05, 10.0, 0),
                      child: FloatingActionButton(
                        onPressed: () async {
                          String provider_login = FirebaseAuth
                              .instance.currentUser!.providerData[0].providerId;
                          Navigator.pushNamed(context, "/login",
                              arguments: {"provider": provider_login});
                        },
                        elevation: 0,
                        backgroundColor: colorePrimario,
                        shape: CircleBorder(
                            side: BorderSide(
                                color: coloreSecondario, width: 1.5)),
                        child: foto_profilo == ""
                            ? Icon(
                                Icons.person,
                                color: coloreSecondario,
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(foto_profilo),
                                backgroundColor: Colors.transparent,
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
