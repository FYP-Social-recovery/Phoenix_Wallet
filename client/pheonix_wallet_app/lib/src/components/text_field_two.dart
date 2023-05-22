import 'package:flutter/material.dart';

class TextFieldTwo extends StatelessWidget {
  const TextFieldTwo({
    super.key,
    required this.labelText,
    required this.controller,
    this.hintText = "",
    this.isEditable = true,
    this.fontSize = 25,
    this.fontWeight = FontWeight.normal,
    this.fontColor = Colors.grey,
    this.labelSize = 25,
    this.labelWeight = FontWeight.normal,
    this.labelColor = Colors.grey,
    this.borderColor = Colors.grey,
    this.contentPadding = const EdgeInsets.only(
      left: 20,
      top: 20,
      bottom: 20,
    ),
    this.fontTextAlign = TextAlign.start,
  });

  final String labelText;
  final TextEditingController controller;
  final String hintText;
  final bool isEditable;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? labelSize;
  final Color? fontColor;
  final TextAlign fontTextAlign;
  final FontWeight? labelWeight;
  final Color? labelColor;
  final Color borderColor;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        maxLines: 5,
        minLines: 1,
        enabled: isEditable,
        style: TextStyle(
          color: fontColor,
          fontSize: fontSize,
          letterSpacing: 0.5,
          fontWeight: fontWeight,
        ),
        textAlign: fontTextAlign,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 25,
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: labelColor,
            fontSize: labelSize,
            fontWeight: labelWeight,
          ),
          contentPadding: contentPadding,
          // prefixIcon: Icon(Icons.people),
          border: OutlineInputBorder(
            //Outline border type for TextFeild
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            //Outline border type for TextFeild
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
        ));
  }
}
