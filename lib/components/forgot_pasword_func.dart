import 'package:flutter/material.dart';

import '../screens/forget_password_screen.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgetPassword()),
              );
            },
            child: Text('forget Password?')),
      ],
    );
  }
}