import 'package:price_app/features/components/appbar_leading_arrow.dart';
import 'package:price_app/features/components/bottom_action_text.dart';
import 'package:price_app/features/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_app/features/components/my_text_field.dart';
import 'package:flutter/widgets.dart';
import 'package:price_app/features/components/forgot_pasword_func.dart';
import 'package:price_app/features/components/my_text_button.dart';
import 'package:price_app/features/registration/registration_screen1.dart';


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
               Text('Welcome back. Glad to see you Again!',
                style: KHeadingTextStyle,
              ),
              const SizedBox(height: 15),
              CustomTextField(placeholder: 'PH-Code/Email'),
              const SizedBox(height: 10),
              CustomTextField(
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

