import "package:price_app/features/utils/exports.dart";

class CustomTextField extends StatelessWidget {
  final String placeholder;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  CustomTextField({
    required this.placeholder,
    this.obscureText=false,
    this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        keyboardType: keyboardType,
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