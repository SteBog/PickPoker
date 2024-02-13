// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pick_poker/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Risik extends StatefulWidget {
  const Risik({super.key});

  @override
  State<Risik> createState() => _RisikState();
}

var data;

class _RisikState extends State<Risik> {
  var puntata;
  var crediti;
  var punteggio;
  var utente;

  @override
  void initState() {
    mazzo = [];
    for (var i in numeri) {
      for (var j in semi) {
        Carta temp = Carta(numero: i, seme: j);
        mazzo.add(temp);
      }
    }
    mazzo.shuffle();
    super.initState();
  }

  void aggiornaCrediti() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('utenti/$utente/');

    await ref.update({
      "crediti": crediti,
    });
  }

  bool mossa = true;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;
    puntata = data["puntata"];
    crediti = data["crediti"];
    punteggio = data["punteggio"];
    utente = data["utente"];

    final double itemHeight =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = MediaQuery.of(context).size.width / 2;

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
            child: Align(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(200, 0, 0, 0),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
                  Divider(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Expanded(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: GridView.builder(
                          itemCount: 52,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 0.0,
                                  mainAxisSpacing: 5.0,
                                  childAspectRatio: itemHeight / itemWidth),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: RotatedBox(
                                  quarterTurns: 1,
                                  child: mazzo[index].immagine),
                              onTap: () {
                                if (mazzo[index].coperta && mossa) {
                                  mossa = false;
                                  setState(() {
                                    mazzo[index].immagine = Image.asset(
                                        "assets/img/Carte/${mazzo[index].numero}${mazzo[index].seme}.png");
                                  });
                                  if (checkCard(mazzo[index])) {
                                    crediti +=
                                        moltiplicatori[punteggio] * puntata;
                                  } else {
                                    crediti -=
                                        moltiplicatori[punteggio] * puntata +
                                            puntata;
                                  }
                                  aggiornaCrediti();
                                  Timer tempo = Timer(Duration(seconds: 2), () {
                                    Navigator.popUntil(
                                        context, ModalRoute.withName('/home'));
                                  });
                                }
                              },
                            );
                          },
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool checkCard(Carta scelta) {
    return scelta.numero == "A" ||
        scelta.numero == "J" ||
        scelta.numero == "Q" ||
        scelta.numero == "K";
  }
}
