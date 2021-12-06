import 'package:flutter/material.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class AppButtons extends StatelessWidget {
  final Color color;
  final String? text;
  final IconData? icon;
  final Color backgroundColor;
  final double size;
  final Color borderColor;
  final bool? isIcon;
  
  const AppButtons({Key? key,
  this.isIcon=false,
  this.text,
  this.icon,
  required this.size,
  required this.color, 
  required this.backgroundColor, 
  required this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.buttonBackground,
      ),
      child: isIcon==false?AppText(text!, color: color,):Icon(icon, color: color,),
    );
  }
}
