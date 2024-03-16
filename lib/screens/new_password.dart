import 'package:price_app/components/appbar_leading_arrow.dart';
import 'package:price_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_app/components/my_text_field.dart';

import '../components/my_text_button.dart';



class NewPassword extends StatelessWidget {

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
              const Text('Create new Password',
                style: KHeadingTextStyle
              ),
              Text('Your new password must be unique from those previously used.',
              style: KSubHeadingTextStyle,
              ),
              const SizedBox(height: 15),
              MyTextField(placeholder: 'New Password'),
              const SizedBox(height: 10),
              MyTextField(
                  placeholder: 'Confirm Password',),
              const SizedBox(height: 80),
              MyTextButton(buttonText: 'Reset Password', onPressed: () {},),
            ],
          ),
        )
    );
  }
}