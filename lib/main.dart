import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../pages/splash.dart';
import '../utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.scaffoldBg,
        primarySwatch: AppColors.primarySwatch,
        colorScheme: AppColors.lightTheme,
      ),
      dark: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.scaffoldBgDark,
        primarySwatch: AppColors.primarySwatch,
        colorScheme: AppColors.darkTheme,
      ),
      initial: AdaptiveThemeMode.system,
      builder: (ThemeData light, ThemeData dark) => GetMaterialApp(
        title: 'Adventuree',
        localizationsDelegates: [FormBuilderLocalizations.delegate],
        debugShowCheckedModeBanner: false,
        theme: light,
        darkTheme: dark,
        home: SplashPage(),
      ),
    );
  }
}
