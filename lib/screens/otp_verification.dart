import 'package:price_app/components/appbar_leading_arrow.dart';
import 'package:price_app/components/bottom_action_text.dart';
import 'package:price_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_app/components/my_text_field.dart';
import '../components/my_text_button.dart';
import '../components/otp_box.dart';
import 'new_password.dart';



class Verification extends StatelessWidget {

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
              const Text('OTP Verification',
                style: KHeadingTextStyle,
              ),
              Text('Enter the verification code we just sent on you email address',
              style:KSubHeadingTextStyle,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OTPBox(),
                  OTPBox(),
                  OTPBox(),
                  OTPBox(),
                ],
              ),

              const SizedBox(height: 80),
              MyTextButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute
                    (builder: (context) => NewPassword()),
                );
              },
                buttonText: 'Verify',),
              Spacer(),
              BottomActionText(question: "Did not received code?", action: 'Resend', onTap: (){},),
            ],
          ),
        )
    );
  }
}


