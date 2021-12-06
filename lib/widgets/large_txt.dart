import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class AppLargeText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final bool centerAlign;

  const AppLargeText(
    this.text, {
    Key? key,
    this.size = 28.0,
    this.color = AppColors.onBackground,
    this.centerAlign = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: centerAlign ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
