import 'package:flutter/material.dart';

class TextFieldOne extends StatelessWidget {
  const TextFieldOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        Positioned(
          top: 3,
          left: 30,
          child: Text(
            'Email Address',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        Positioned(
          left: 30,
          bottom: 3,
          right: 30,
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter email'),
            onChanged: (s) {
              // text = s;
            },
          ),
        )
      ],
    );
  }
}
