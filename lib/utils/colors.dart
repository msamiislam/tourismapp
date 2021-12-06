import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppColors {
  static final Color textColor1 = Color(0xFF989acd);
  static final Color textColor2 = Color(0xFF878593);
  static final Color bigTextColor = Color(0xFF2e2e31);
  static final Color mainColor = Color(0xFF5d69b3);
  static final Color starColor = Color(0xFFe7bb4e);
  static final Color mainTextColor = Color(0xFFababad);
  static final Color buttonBackground = Color(0xFFf1f2f9);

  static const Color black = Colors.black;
  static const Color white = Colors.white;

  static const Color scaffoldBg = Colors.white;

  static const _kPrimaryVal = 0xFFc32053;
  static const Color primary = Color(_kPrimaryVal);

  static const MaterialColor primarySwatch = MaterialColor(
    _kPrimaryVal,
    <int, Color>{
      50:  Color(0xFFe190a9),
      100: Color(0xFFdb7998),
      200:  Color(0xFFd56387),
      300:  Color(0xFFcf4d75),
      400:  Color(0xFFc93664),
      500:  Color(_kPrimaryVal),
      600:  Color(0xFFb01d4b),
      700:  Color(0xFF9c1a42),
      800:  Color(0xFF89163a),
      900:  Color(0xFF751332),
    },
  );


}