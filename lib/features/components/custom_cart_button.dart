import "dart:ui";
import "package:price_app/features/utils/exports.dart";

class CustommCartButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  CustommCartButton({required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.red,
        ),
        alignment: Alignment.center,
        width: double.infinity,
        height: 30,
        child: Expanded(
          child: Text(buttonText,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}