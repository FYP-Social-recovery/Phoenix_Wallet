import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopHeaderBar extends StatelessWidget {
  const TopHeaderBar({
    this.isBackAvailable = false,
    required this.title,
    super.key,
  });

  final bool isBackAvailable;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xFF343434),
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          isBackAvailable
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFF343434),
                        size: 30,
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
