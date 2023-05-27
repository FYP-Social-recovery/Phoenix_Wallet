import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pheonix_wallet_app/src/constants.dart';

class HomePanelButton extends StatelessWidget {
  const HomePanelButton({
    super.key,
    required this.onTap,
    required this.image,
    required this.label,
    this.size = 60,
    this.shape = BoxShape.rectangle,
  });

  final Function()? onTap;
  final String image;
  final String label;
  final double size;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: AppColors.mainBlue,
              borderRadius: BoxShape.rectangle == shape
                  ? BorderRadius.circular(10)
                  : BorderRadius.circular(100),
            ),
            child: Center(
              child: Image.asset(
                image,
                width: size - 10,
                height: size - 10,
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: AppColors.mainBlue,
                fontSize: 10,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
