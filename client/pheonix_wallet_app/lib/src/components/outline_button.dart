import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.color = const Color(0xFF115DA9),
  });

  final String buttonText;
  final VoidCallback? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Container(
        width: 180,
        height: 50,
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: color,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return color.withOpacity(0.1);
          }
          return Colors.transparent;
        }),
      ),
      onPressed: onPressed,
    );
  }
}
