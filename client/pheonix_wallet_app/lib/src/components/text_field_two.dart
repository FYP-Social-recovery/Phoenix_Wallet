import 'package:flutter/material.dart';

class TextFieldTwo extends StatelessWidget {
  const TextFieldTwo({
    super.key,
    required this.labelText,
    required this.controller,
    this.hintText = "",
  });

  final String labelText;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        maxLines: 5,
        minLines: 1,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 25,
          letterSpacing: 0.5,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 25,
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 25,
          ),
          contentPadding: const EdgeInsets.only(
            left: 20,
            top: 20,
            bottom: 20,
          ),
          // prefixIcon: Icon(Icons.people),
          border: const OutlineInputBorder(
            //Outline border type for TextFeild
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Color(0xFF575757),
              width: 1,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            //Outline border type for TextFeild
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Color(0xFF575757),
              width: 1,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: Color(0xFF575757),
              width: 1,
            ),
          ),
        ));
  }
}
