import 'package:price_app/components/appbar_leading_arrow.dart';
import 'package:flutter/material.dart';
import 'package:price_app/components/my_text_field.dart';
import '../components/bottom_action_text.dart';
import '../components/my_text_button.dart';
import '../constants.dart';
import 'login_screen.dart';

class Registration2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading: AppBarLeadingArrow()),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Awesome! You're almost done",
                style: KHeadingTextStyle,
              ),
              SizedBox(height: 15),
              MyTextField(placeholder: 'Gender*'),
              SizedBox(height: 10),
              MyTextField(placeholder: 'Date of Birth*'),
              SizedBox(height: 10),
              MyTextField(placeholder: 'Country of Residence*'),
              SizedBox(height: 10),
              MyTextField(placeholder: 'State of Residence*'),
              const SizedBox(height: 80),
              MyTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registration3');
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
              ),
            ],
          ),
        ));
  }
}
