import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    Key? key,
    this.textAlign,
    this.fontSize = 15,
    this.fontWeight,
    this.color,
    this.textOverflow,
  }) : super(key: key);

  final String text;
  final TextAlign? textAlign;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
      overflow: textOverflow,
    );
  }
}
