import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.color = const Color.fromRGBO(255, 109, 0, 1),
  });

  final String buttonText;
  final VoidCallback? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 15,
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(0),
              backgroundColor: MaterialStateProperty.all<Color>(
                color,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(
                    color: color,
                  ),
                ),
              ),
            ),
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
