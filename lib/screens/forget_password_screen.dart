import 'package:price_app/components/appbar_leading_arrow.dart';
import 'package:price_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_app/components/my_text_field.dart';
import '../components/bottom_action_text.dart';
import '../components/my_text_button.dart';
import 'login_screen.dart';
import 'otp_verification.dart';

class ForgetPassword extends StatelessWidget {
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
              const Text(
                'Forget Password?',
                style: KHeadingTextStyle,
              ),
              const Text(
                "Don't worry it occurs. "
                "Please enter the email address used with your account",
                style: KSubHeadingTextStyle,
              ),
              const SizedBox(height: 15),
              MyTextField(placeholder: 'Enter your email'),
              const SizedBox(height: 80),
              MyTextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Verification()),
                  );
                },
                buttonText: 'Send Code',
              ),
              Spacer(),
              BottomActionText(
                question: 'Remember Password?',
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
