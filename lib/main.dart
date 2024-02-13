// ignore_for_file: prefer_const_constructors
import 'package:pick_poker/components/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:pick_poker/components/gioca.dart';
import 'package:pick_poker/components/login.dart';
import 'package:pick_poker/components/premi.dart';
import 'package:pick_poker/components/punta.dart';
import 'package:pick_poker/components/risik.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/home",
      routes: {
        "/home": (context) => Home(),
        "/punta": (context) => Punta(),
        "/gioco": (context) => Gioca(),
        "/premi": (context) => Premi(),
        "/rischio": (context) => Risik(),
        "/login": (context) => Login(),
      },
    );
  }
}
