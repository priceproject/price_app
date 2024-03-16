import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_app/components/my_text_field.dart';
import 'package:price_app/components/appbar_leading_arrow.dart';
import 'package:flutter/widgets.dart';

import '../components/bottom_action_text.dart';
import '../components/my_text_button.dart';
import '../constants.dart';
import 'login_screen.dart';

class Registration1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: AppBarLeadingArrow(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Hello! Register to get Started',
                  style: KHeadingTextStyle),
              const SizedBox(height: 15),
              MyTextField(placeholder: 'Firstname*'),
              const SizedBox(height: 10),
              MyTextField(placeholder: 'Lastname*'),
              const SizedBox(height: 10),
              MyTextField(placeholder: 'Email*'),
              const SizedBox(height: 10),
              MyTextField(placeholder: 'Phone number*'),
              const SizedBox(height: 80),
              MyTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registration2');
                },
                buttonText: 'Continue',
              ),
              Spacer(),

              BottomActionText(
                question: 'Already have an account?',
                action: 'Login',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              )
            ],
          ),
        ));
  }
}
