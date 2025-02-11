import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.textColor = Colors.white,
    this.validate = true,
  });

  final String? text;
  final void Function()? onPressed;
  final Color color;
  final Color? textColor;
  final bool validate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: validate ? onPressed : null,
      child: Container(
        height: 60,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: validate ? color : Colors.grey.shade400, // Disabled color
          borderRadius: BorderRadius.circular(20), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(3, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Text(
          text ?? '',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Bold text
            fontSize: 18.0,
            color: validate ? textColor : Colors.black54, // Disabled text color
          ),
        ),
      ),
    );
  }
}
