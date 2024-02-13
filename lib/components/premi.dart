// ignore_for_file: prefer_const_constructors
import 'package:firebase_database/firebase_database.dart';
import 'package:pick_poker/constants.dart';
import 'package:flutter/material.dart';
import 'package:pick_poker/scoreChecker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Premi extends StatefulWidget {
  const Premi({super.key});

  @override
  State<Premi> createState() => _PremiState();
}

class _PremiState extends State<Premi> {
  late int puntata;
  var crediti;
  var data;
  var utente;
  bool chiudi = false;

  void aggiornaCrediti() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('utenti/$utente/');

    await ref.update({
      "crediti": crediti,
    });
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;
    crediti = data["credito"];
    puntata = data["puntata"];
    utente = data["utente"];

    int punteggio = indexScore(data["scelte"]);
    punteggio != -1
        ? crediti += moltiplicatori[punteggio] * puntata
        : crediti -= puntata;

    aggiornaCrediti();

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
            children: [
              ParteInAlto(
                  testo: "Rewards",
                  paddingParteInAlto: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.028,
                      horizontal: MediaQuery.of(context).size.width * 0.07),
                  fontSizeParteInAlto:
                      MediaQuery.of(context).size.height * 0.055),
              Divider(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                    color: Color.fromARGB(200, 0, 0, 0),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Text(
                  punteggio != -1 ? vincite[punteggio] : "Nothing",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Divider(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "${"assets/img/Carte/" + data["scelte"][0].numero + data["scelte"][0].seme}.png",
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                  Image.asset(
                    "${"assets/img/Carte/" + data["scelte"][1].numero + data["scelte"][1].seme}.png",
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                  Image.asset(
                    "${"assets/img/Carte/" + data["scelte"][2].numero + data["scelte"][2].seme}.png",
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                  Image.asset(
                    "${"assets/img/Carte/" + data["scelte"][3].numero + data["scelte"][3].seme}.png",
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                  Image.asset(
                    "${"assets/img/Carte/" + data["scelte"][4].numero + data["scelte"][4].seme}.png",
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                ],
              ),
              Divider(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 30, 0, 10),
                        child: Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(200, 0, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  "assets/img/Icona-monete.svg",
                                  height: 22,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  punteggio != -1
                                      ? (puntata * moltiplicatori[punteggio])
                                          .toString()
                                      : "0",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(200, 0, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.attach_money,
                                color: coloreSecondario,
                                size: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  crediti.toString(),
                                  style: TextStyle(
                                      color: coloreSecondario,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: MediaQuery.of(context).size.height * 0.13,
              ),
              Row(
                mainAxisAlignment: punteggio != -1
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.center,
                children: [
                  punteggio != -1
                      ? RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              chiudi = true;
                            });
                            Navigator.pushReplacementNamed(context, "/rischio",
                                arguments: {
                                  "puntata": puntata,
                                  "crediti": crediti,
                                  "punteggio": punteggio,
                                  "utente": utente
                                });
                          },
                          fillColor: Color(0xff810000),
                          shape: CircleBorder(
                              side: BorderSide(
                                  color: Color(0xffffDD00), width: 3)),
                          padding: EdgeInsets.all(20),
                          child: Icon(
                            Icons.star,
                            size: 60,
                            color: coloreSecondario,
                          ),
                        )
                      : Container(),
                  RawMaterialButton(
                    onPressed: () {
                      setState(() {
                        chiudi = true;
                      });
                      Navigator.popUntil(context, ModalRoute.withName("/home"));
                    },
                    fillColor: Color(0xff810000),
                    shape: CircleBorder(
                        side: BorderSide(color: Color(0xffffDD00), width: 3)),
                    padding: EdgeInsets.all(20),
                    child: Icon(
                      Icons.home,
                      size: 60,
                      color: coloreSecondario,
                    ),
                  )
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }
}
