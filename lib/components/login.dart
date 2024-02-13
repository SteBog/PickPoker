// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pick_poker/constants.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var data;
  var provider;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;
    provider = data["provider"];
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
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                if (provider == "google.com")
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff810000),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Color(0xffFFDD00), width: 3)),
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Text(
                      "Logged in with Google",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffffDD00),
                        fontSize: 30,
                      ),
                    ),
                  ),
                if (provider == "facebook.com")
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xff810000),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(color: Color(0xffFFDD00), width: 3)),
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Text(
                      "Logged in with Google",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffffDD00),
                        fontSize: 30,
                      ),
                    ),
                  ),
                if (provider == "")
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: FloatingActionButton.extended(
                          heroTag: "login_google",
                          onPressed: signInWithGoogle,
                          label: Text(
                            "Login with Google",
                            style: TextStyle(color: coloreSecondario),
                          ),
                          backgroundColor: colorePrimario,
                          shape: ContinuousRectangleBorder(
                              side: BorderSide(color: coloreSecondario),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: FloatingActionButton.extended(
                          heroTag: "login_facebook",
                          onPressed: signInWithFacebook,
                          label: Text(
                            "Login with Facebook",
                            style: TextStyle(color: coloreSecondario),
                          ),
                          backgroundColor: colorePrimario,
                          shape: ContinuousRectangleBorder(
                              side: BorderSide(color: coloreSecondario),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
