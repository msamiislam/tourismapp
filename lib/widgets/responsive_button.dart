import 'package:flutter/material.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class ResponsiveButton extends StatelessWidget {
  final bool? isResponsive;
  final double? width;

  const ResponsiveButton({
    Key? key,
    this.isResponsive = false,
    this.width = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: isResponsive == true ? double.maxFinite : width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.mainColor,
        ),
        child: Row(
          mainAxisAlignment:isResponsive==true?MainAxisAlignment.spaceBetween: MainAxisAlignment.center,
          children: [
            //for show text in button
            isResponsive==true?Container(
              margin: const EdgeInsets.only(left: 20),
             child: AppText(text: "Book Trip Now", color: Colors.white,)):Container(),

             //for show icon in button
            Image.asset("img/responsivebutton.png"),
          ],
        ),
      ),
    );
  }
}