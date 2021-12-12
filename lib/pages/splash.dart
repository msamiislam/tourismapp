import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourismapp/models/attraction_model.dart';

import '../controllers/login_controller.dart';
import '../models/user_model.dart';
import 'tourist/dashboard.dart';
import '../pages/login.dart';
import '../pages/welcome.dart';
import '../services/database.dart';
import 'guide/dashboard.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final LoginController _login = Get.put(LoginController());

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) async {
      List<AttractionModel> attractions = await Database.getTopAttractions();
      Get.put(attractions, tag: "attractions");
      if (_login.isAppOpened) {
        if (FirebaseAuth.instance.currentUser == null) {
          Get.offAll(() => LoginPage());
        } else {
          if (!_login.hasUserData) {
            UserModel user = await Database.getUser(FirebaseAuth.instance.currentUser!.uid);
            _login.updateUser(user);
          }
          if (_login.user!.isGuide) {
            Get.off(() => GuideDashboardPage());
          } else {
            Get.off(() => DashboardPage());
          }
        }
      } else {
        _login.appOpened();
        Get.off(() => WelcomePage());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: Get.width,
      height: Get.height,
      child: Image.asset("img/splash.png", fit: BoxFit.cover),
    ));
  }
}
