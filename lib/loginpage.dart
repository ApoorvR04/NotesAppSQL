import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_app/google_auth.dart';
import 'package:notes_app/homepage.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150.0, bottom: 80.0),
              child: Text("Welcome to Notes App",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ) ,),
            ),
            Container( height: 220,

              decoration :new BoxDecoration(
                image: new DecorationImage(image: ExactAssetImage("assets/images/noteimage.png")
                )
              ),
            ),
            SizedBox(height: 20,),

            Text("Sign-in to continue"),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignInButton(Buttons.Google,
                    onPressed: onPressSignIn
                  )
                ],
              )
            )

          ],
        ),
      ),
    );
  }
   void onPressSignIn() {
    signInWithGoogle(context).then((value) => nextPage());
  }
  void nextPage() {
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=> HomePage()));
  }
}
