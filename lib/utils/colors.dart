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

  // Color Scheme

  static const Color black = Colors.black;
  static const Color white = Colors.white;

  static const Color scaffoldBg = Colors.white;

  static const _kPrimaryVal = 0xFFed672e;
  static const Color primary = Color(_kPrimaryVal);
  static const Color onPrimary = Colors.white;
  static const Color primaryVariant = Color(0xFFa64820); //30%

  static const Color secondary = Color(0xFFab8372);
  static const Color onSecondary = Colors.white;
  static const Color secondaryVariant = Color(0xFF785c50); //30%

  static const Color background = Colors.white;
  static const Color onBackground = Colors.black;

  static const Color surface = Colors.white;
  static const Color onSurface = Colors.black;

  static MaterialColor primarySwatch = generateMaterialColorFromColor(primary);

  static MaterialColor generateMaterialColorFromColor(Color color) {
    return MaterialColor(color.value, {
      50: Color.fromRGBO(color.red, color.green, color.blue, 0.1),
      100: Color.fromRGBO(color.red, color.green, color.blue, 0.2),
      200: Color.fromRGBO(color.red, color.green, color.blue, 0.3),
      300: Color.fromRGBO(color.red, color.green, color.blue, 0.4),
      400: Color.fromRGBO(color.red, color.green, color.blue, 0.5),
      500: Color.fromRGBO(color.red, color.green, color.blue, 0.6),
      600: Color.fromRGBO(color.red, color.green, color.blue, 0.7),
      700: Color.fromRGBO(color.red, color.green, color.blue, 0.8),
      800: Color.fromRGBO(color.red, color.green, color.blue, 0.9),
      900: Color.fromRGBO(color.red, color.green, color.blue, 1.0),
    });
  }

}