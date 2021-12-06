import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final double size;
  final String text;
  final int? maxLines;
  final Color? color;
  final FontWeight weight;

  const AppText(
      this.text,
      {
    Key? key,
    this.size = 14.0,
    this.color,
    this.maxLines,
    this.weight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}