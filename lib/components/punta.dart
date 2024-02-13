// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:pick_poker/constants.dart';
import 'package:flutter_svg/svg.dart';

class Punta extends StatefulWidget {
  const Punta({super.key});

  @override
  State<Punta> createState() => _PuntaState();
}

class _PuntaState extends State<Punta> {
  int puntata = 0;
  var crediti;
  var utente;
  late var data;

  void aggiungi(int quanto) {
    if (puntata <= crediti - quanto) {
      setState(() {
        puntata += quanto;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;
    crediti = data["credito"];
    utente = data["utente"];
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/Campo.jpg"),
                    fit: BoxFit.fitHeight)),
            child: SafeArea(
                child: Column(
              children: [
                ParteInAlto(
                  testo: "Bet",
                  fontSizeParteInAlto:
                      MediaQuery.of(context).size.height * 0.055,
                  paddingParteInAlto: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.028,
                      horizontal: MediaQuery.of(context).size.width * 0.07),
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(200, 0, 0, 0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(200, 0, 0, 0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      puntata.toString(),
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
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                Flex(
                  mainAxisAlignment: MainAxisAlignment.center,
                  direction: Axis.horizontal,
                  children: [
                    if (crediti - puntata >= 1)
                      FloatingActionButton(
                        heroTag: "punta1",
                        onPressed: (() {
                          aggiungi(1);
                        }),
                        child: Image.asset("assets/img/Fiches/fiches_1.png"),
                      ),
                    if (crediti - puntata >= 5)
                      FloatingActionButton(
                        heroTag: "punta5",
                        onPressed: (() {
                          aggiungi(5);
                        }),
                        child: Image.asset("assets/img/Fiches/fiches_5.png"),
                      ),
                    if (crediti - puntata >= 25)
                      FloatingActionButton(
                        heroTag: "punta25",
                        onPressed: (() {
                          aggiungi(25);
                        }),
                        child: Image.asset("assets/img/Fiches/fiches_25.png"),
                      ),
                    if (crediti - puntata >= 50)
                      FloatingActionButton(
                        heroTag: "punta50",
                        onPressed: (() {
                          aggiungi(50);
                        }),
                        child: Image.asset("assets/img/Fiches/fiches_50.png"),
                      ),
                    if (crediti - puntata >= 100)
                      FloatingActionButton(
                        heroTag: "punta100",
                        onPressed: (() {
                          aggiungi(100);
                        }),
                        child: Image.asset("assets/img/Fiches/fiches_100.png"),
                      ),
                    if (crediti - puntata >= 500)
                      FloatingActionButton(
                        heroTag: "punta500",
                        onPressed: (() {
                          aggiungi(500);
                        }),
                        child: Image.asset("assets/img/Fiches/fiches_500.png"),
                      ),
                  ],
                ),
                Divider(height: MediaQuery.of(context).size.height * 0.05),
                if (puntata > 0)
                  ButtonGioca(
                    puntata: puntata,
                    crediti: crediti,
                    utente: utente,
                  )
              ],
            )),
          ),
        ],
      ),
    );
  }
}

class ButtonGioca extends StatelessWidget {
  const ButtonGioca(
      {super.key,
      required this.puntata,
      required this.crediti,
      required this.utente})
      : super();

  final int puntata;
  final int crediti;
  final utente;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.pushNamed(context, "/gioco", arguments: {
          "puntata": puntata,
          "credito": crediti,
          "utente": utente
        });
      },
      fillColor: Color(0xff810000),
      shape: CircleBorder(side: BorderSide(color: Color(0xffffDD00), width: 3)),
      padding: EdgeInsets.all(10),
      child: Icon(
        Icons.play_arrow,
        color: Color(0xffffDD00),
        size: 70,
      ),
    );
  }
}
