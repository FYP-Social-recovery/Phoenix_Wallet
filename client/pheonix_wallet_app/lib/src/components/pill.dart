import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  const Pill(
      {Key? key,
      required this.prefix,
      required this.label,
      required this.color})
      : super(key: key);

  final String prefix;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(
          prefix,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }
}
