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
    return GetMaterialApp(
      title: 'Adventuree',
      localizationsDelegates: [FormBuilderLocalizations.delegate],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.scaffoldBg,
        primarySwatch: AppColors.primarySwatch,
        colorScheme: ColorScheme(
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          primaryVariant: AppColors.primaryVariant,
          secondary: AppColors.secondary,
          onSecondary: AppColors.onSecondary,
          secondaryVariant: AppColors.secondaryVariant,
          background: AppColors.background,
          onBackground: AppColors.onBackground,
          surface: AppColors.surface,
          onSurface: AppColors.onSurface,
          error: Theme.of(context).errorColor,
          onError: AppColors.white,
          brightness: Brightness.light,
        ),
      ),
      home: SplashPage(),
    );
  }
}
