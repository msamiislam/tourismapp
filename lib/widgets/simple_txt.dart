import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final double? size;
  final String text;
  final int? maxLines;
  final double? height;
  final Color? color;
  final TextOverflow? overflow;
  final FontWeight weight;

  const AppText(
    this.text, {
    Key? key,
    this.size,
    this.color,
    this.maxLines,
    this.height,
    this.overflow,
    this.weight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        height: height,
        fontSize: size,
        fontWeight: weight,
        overflow: overflow,
      ),
    );
  }
}
