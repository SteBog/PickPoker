// ignore_for_file: prefer_const_constructors
import 'package:pick_poker/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Gioca extends StatefulWidget {
  const Gioca({super.key});

  @override
  State<Gioca> createState() => _GiocaState();
}

class _GiocaState extends State<Gioca> {
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

  int scelte = 5;
  String titolo = "5 choices left";
  var data;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;
    int puntata = data["puntata"];
    var crediti = data["credito"];
    var utente = data["utente"];

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(200, 0, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                scelte.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Container(
                          width: 100,
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
                  Divider(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Expanded(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.90,
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
                              onTap: () async {
                                setState(() {
                                  if (mazzo[index].coperta && scelte > 0) {
                                    mazzo[index].immagine = Image.asset(
                                        "assets/img/Carte/${mazzo[index].numero}${mazzo[index].seme}.png");
                                    mazzo[index].coperta = false;
                                    scelte = scelte - 1;
                                    titolo = "$scelte choices left";
                                    if (scelte == 1) {
                                      titolo = "$scelte choice left";
                                    }
                                  }
                                });
                                if (scelte <= 0) {
                                  Navigator.pushNamed(context, "/premi",
                                      arguments: {
                                        "scelte": mazzo
                                            .where((i) => !i.coperta)
                                            .toList(),
                                        "puntata": puntata,
                                        "credito": crediti,
                                        "utente": utente
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
}
