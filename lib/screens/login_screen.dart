import 'package:price_app/components/appbar_leading_arrow.dart';
import 'package:price_app/components/bottom_action_text.dart';
import 'package:price_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_app/components/my_text_field.dart';
import 'package:flutter/widgets.dart';
import '../components/forgot_pasword_func.dart';
import '../components/my_text_button.dart';
import 'registration_screen1.dart';


class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading:AppBarLeadingArrow(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Welcome back. Glad to see you Again!',
                style: KHeadingTextStyle,
              ),
              const SizedBox(height: 15),
              MyTextField(placeholder: 'PH-Code/Email'),
              const SizedBox(height: 10),
              MyTextField(
                  placeholder: 'Enter your Password',
                  obscureText: true),
              ForgotPassword(),
              const SizedBox(height: 80),
              MyTextButton(buttonText: 'Login', onPressed: () {  },),
              Spacer(),
              BottomActionText(question: 'Already have PH-Code?', action: 'Register Here', onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute
                    (builder: (context) => Registration1()),
                );
              },),
            ],
          ),
        )
    );
  }
}

