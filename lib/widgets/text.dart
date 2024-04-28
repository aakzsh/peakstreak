import 'package:flutter/material.dart';

class GetText extends StatelessWidget {
  const GetText({super.key, required this.fontSize, required this.color, required this.centerAlign, required this.text});
  final double fontSize;
  final Color color;
  final bool centerAlign;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: fontSize, color: color), textAlign: centerAlign?TextAlign.center: TextAlign.start,);
  }
}