import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:tourismapp/pages/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Adventuree',
      localizationsDelegates: [FormBuilderLocalizations.delegate],
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // BlocProvider<AppCubits>(
      // create:(context)=>AppCubits(
      //   data: DataServices(),
      // ),
      // child: AppCubitsLogic(),
      // )
    );
  }
}
