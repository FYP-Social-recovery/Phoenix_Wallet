import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pheonix_wallet_app/src/constants.dart';

class RequestBox extends StatelessWidget {
  const RequestBox({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onPressed,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  final String title;
  final String subTitle;
  final Function()? onPressed;
  final IconData icon;
  final Color color;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainBlue,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      height: 76,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: AppColors.boxTextPink,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    subTitle,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 7,
            ),
            IconButton(
              onPressed: onPressed,
              icon: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 25,
                  weight: 20,
                ),
              ),
              padding: EdgeInsets.all(0),
            ),
          ],
        ),
      ),
    );
  }
}
