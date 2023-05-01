import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  final String buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 15,
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Color.fromRGBO(255, 109, 0, 1),
                  fontSize: 25,
                ),
              ),
            ),
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                BorderSide(
                  color: Color.fromRGBO(255, 109, 0, 1),
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Color.fromRGBO(255, 111, 0, 1).withOpacity(0.1);
                }
                return Colors.transparent;
              }),
            ),
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
