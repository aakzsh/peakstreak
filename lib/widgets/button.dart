import 'package:flutter/material.dart';
import 'package:peakstreak/widgets/text.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.color,
      required this.onPressed});
  final String text;
  final Color color;
  final Function onPressed;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: MaterialButton(
        onPressed: () {
          widget.onPressed();
        },
        height: 60,
        color: widget.color,
        minWidth: double.maxFinite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: GetText(
            fontSize: 20.0,
            color: Colors.white,
            centerAlign: true,
            text: widget.text),
      ),
    );
  }
}
