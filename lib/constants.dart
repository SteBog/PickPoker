import 'package:flutter/material.dart';

Color colorePrimario = const Color(0xff810000);
Color coloreSecondario = const Color(0xffFFDD00);
final List<int> moltiplicatori = [100, 50, 25, 15, 10, 5, 2, 1, 0];

List<String> numeri = [
  "A",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "J",
  "Q",
  "K"
];
List<String> semi = ["H", "D", "C", "S"];
List<String> vincite = [
  "Royal Flush",
  "Straight Flush",
  "Poker",
  "Full House",
  "Flush",
  "Straight",
  "Three of kind",
  "Two Pairs",
  "Pair"
];

late List<Carta> mazzo;

class BoxInfo extends StatelessWidget {
  const BoxInfo(
      {super.key,
      required this.contenuto,
      required this.padding,
      required this.fontSize})
      : super();

  final String contenuto;
  final double padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorePrimario,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: coloreSecondario, width: 3),
      ),
      width: MediaQuery.of(context).size.width * 0.90,
      padding: EdgeInsets.all(padding),
      child: Text(
        contenuto,
        style: TextStyle(color: coloreSecondario, fontSize: fontSize),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// ignore: must_be_immutable
class ElencoPremi extends StatefulWidget {
  ElencoPremi(
      {super.key,
      required this.puntata,
      required this.height,
      this.attivo = -1,
      required this.termina,
      required this.width})
      : super();

  final int puntata;
  final int attivo;
  final double height;
  final double width;
  bool termina;

  @override
  _ElencoPremiState createState() => _ElencoPremiState();
}

class _ElencoPremiState extends State<ElencoPremi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorePrimario,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: coloreSecondario, width: 3),
      ),
      height: widget.height,
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          widget.attivo == 0
              ? RigaAttiva(
                  nome: "Royal Flush",
                  moltiplicatore: 250 * widget.puntata,
                  elimina: widget.termina)
              : Riga(nome: "Royal Flush", moltiplicatore: 250 * widget.puntata),
          widget.attivo == 1
              ? RigaAttiva(
                  nome: "Straight Flush",
                  moltiplicatore: 100 * widget.puntata,
                  elimina: widget.termina)
              : Riga(
                  nome: "Straight Flush", moltiplicatore: 100 * widget.puntata),
          widget.attivo == 2
              ? RigaAttiva(
                  nome: "Poker",
                  moltiplicatore: 50 * widget.puntata,
                  elimina: widget.termina)
              : Riga(nome: "Poker", moltiplicatore: 50 * widget.puntata),
          widget.attivo == 3
              ? RigaAttiva(
                  nome: "Full House",
                  moltiplicatore: 25 * widget.puntata,
                  elimina: widget.termina)
              : Riga(nome: "Full House", moltiplicatore: 25 * widget.puntata),
          widget.attivo == 4
              ? RigaAttiva(
                  nome: "Flush",
                  moltiplicatore: 15 * widget.puntata,
                  elimina: widget.termina)
              : Riga(nome: "Flush", moltiplicatore: 15 * widget.puntata),
          widget.attivo == 5
              ? RigaAttiva(
                  nome: "Straight",
                  moltiplicatore: 10 * widget.puntata,
                  elimina: widget.termina)
              : Riga(nome: "Straight", moltiplicatore: 10 * widget.puntata),
          widget.attivo == 6
              ? RigaAttiva(
                  nome: "Three of Kind",
                  moltiplicatore: 5 * widget.puntata,
                  elimina: widget.termina)
              : Riga(nome: "Three of Kind", moltiplicatore: 5 * widget.puntata),
          widget.attivo == 7
              ? RigaAttiva(
                  nome: "Two pairs",
                  moltiplicatore: 2 * widget.puntata,
                  elimina: widget.termina)
              : Riga(nome: "Two pairs", moltiplicatore: 2 * widget.puntata),
          widget.attivo == 8
              ? RigaAttiva(
                  nome: "Pair",
                  moltiplicatore: 1 * widget.puntata,
                  elimina: widget.termina)
              : Riga(nome: "Pair", moltiplicatore: 1 * widget.puntata)
        ],
      ),
    );
  }
}

class ParteInAlto extends StatelessWidget {
  const ParteInAlto(
      {super.key,
      required this.paddingParteInAlto,
      required this.fontSizeParteInAlto,
      required this.testo})
      : super();

  final EdgeInsets paddingParteInAlto;
  final double fontSizeParteInAlto;
  final String testo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: colorePrimario,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50)),
              border: Border.all(color: coloreSecondario, width: 3)),
          padding: paddingParteInAlto,
          width: MediaQuery.of(context).size.width * 0.70,
          child: Text(
            testo,
            style: TextStyle(
                color: coloreSecondario,
                fontSize: fontSizeParteInAlto,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Image.asset(
          "assets/img/Carte/AS.png",
          height: MediaQuery.of(context).size.height * 0.13,
        )
      ],
    );
  }
}

class Riga extends StatefulWidget {
  final String nome;
  final int moltiplicatore;

  Riga({required this.nome, required this.moltiplicatore});

  @override
  _RigaState createState() => _RigaState();
}

class _RigaState extends State<Riga> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.height * 0.0122),
          child: Text(
            widget.nome,
            style: TextStyle(
                color: coloreSecondario,
                fontSize: MediaQuery.of(context).size.height * 0.0245,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              right: MediaQuery.of(context).size.height * 0.0122),
          child: Text(
            widget.moltiplicatore.toString(),
            style: TextStyle(
                color: coloreSecondario,
                fontSize: MediaQuery.of(context).size.height * 0.0245,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

class RigaAttiva extends StatefulWidget {
  final String nome;
  final int moltiplicatore;
  final bool elimina;

  RigaAttiva(
      {super.key,
      required this.nome,
      required this.moltiplicatore,
      required this.elimina});

  @override
  _RigaAttivaState createState() => _RigaAttivaState();
}

class _RigaAttivaState extends State<RigaAttiva>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _animationController.repeat();
    super.initState();
  }

  Widget build(BuildContext context) {
    if (widget.elimina) {
      _animationController.dispose();
    }
    return FadeTransition(
      opacity: _animationController,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.0122),
            child: Text(
              widget.nome,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.0245,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.height * 0.0122),
            child: Text(
              widget.moltiplicatore.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.0245,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class Carta {
  String numero;
  String seme;
  Image immagine = Image.asset("assets/img/Carte/red_back.png");
  bool coperta = true;
  void funzione() {}

  Carta({required this.numero, required this.seme}) {
    // immagine = Image.asset("assets/Carte/" + numero + seme + ".png");
  }
}
