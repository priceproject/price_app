import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_app/features/registration/registration_screen1.dart';
import 'package:price_app/features/components/my_text_button.dart';
import 'package:price_app/features/authentication/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                // height: 300,
                decoration: BoxDecoration(
                  // color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage('images/welcome Screen.png'),
                        fit: BoxFit.fill
                    )
                ),
                // child: Image.asset('images/welcome Screen.png'),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0, right: 30, left: 30, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image(
                      image: AssetImage('images/logo-text.png'),
                      height: 100,
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    MyTextButton(buttonText: 'Login', onPressed: () { Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    ); },),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextButton(buttonText: 'Register', onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute
                          (builder: (context) => Registration1()),
                      );
                    },),
                  ],),
              ),
            )
          ],
        ),
      ),
    );
  }
}

