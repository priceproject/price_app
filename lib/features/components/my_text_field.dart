import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String placeholder;
  final bool ?obscureText;

  CustomTextField({required this.placeholder, this.obscureText=false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextField(
        controller: TextEditingController(),
        obscureText: obscureText!,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          hintText: placeholder,
          prefixText: '  ',
          labelStyle: const TextStyle(
            fontSize: 18,
          ),
          filled: true,
          fillColor: Color(0xFFEFEAEA),
        ),
      ),
    );
  }
}





