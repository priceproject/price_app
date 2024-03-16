import 'package:price_app/components/appbar_leading_arrow.dart';
import 'package:price_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:price_app/components/my_text_field.dart';

import '../components/bottom_action_text.dart';
import '../components/my_text_button.dart';
import 'login_screen.dart';

class Registration3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: AppBarLeadingArrow(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "You're amazing! Now your password",
                style: KHeadingTextStyle
              ),
              SizedBox(height: 15),
              MyTextField(
                placeholder: 'Password*',
                obscureText: true,
              ),
              SizedBox(height: 10),
              MyTextField(
                placeholder: 'Confirm Password',
                obscureText: true,
              ),
              const SizedBox(height: 80),
              MyTextButton(
                buttonText: 'Register',
                onPressed: () {},
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
              ),
            ],
          ),
        ));
  }
}
