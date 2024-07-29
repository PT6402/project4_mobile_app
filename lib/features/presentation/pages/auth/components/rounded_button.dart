import 'package:flutter/material.dart';

class RoudedButton extends StatelessWidget {
  final String text;
  final dynamic press;
  final Color? color, textColor;
  const RoudedButton(
      {super.key,
      required this.text,
      required this.press,
      this.color,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed: press,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: Colors.blueGrey,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
