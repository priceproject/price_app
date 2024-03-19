import 'package:flutter/material.dart';

import '../constants.dart';

class BottomActionText extends StatelessWidget {

  final String question;
  final String action;
  final VoidCallback onTap;

  BottomActionText({required this.question, required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(question),
        SizedBox(width: 5,),
        GestureDetector(
          onTap: onTap,
          child: Text(action,
              style: KLinkTextstyle
          ),
        )
      ],
    );
  }
}