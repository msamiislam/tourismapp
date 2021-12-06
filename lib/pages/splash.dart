import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../models/user_model.dart';
import '../pages/dashboard.dart';
import '../pages/login.dart';
import '../pages/welcome.dart';
import '../utils/database.dart';

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
      if (_login.isAppOpened) {
        if (FirebaseAuth.instance.currentUser == null) {
          Get.offAll(() => LoginPage());
        } else {
          if (!_login.hasUserData) {
            UserModel user = await Database.getUser(FirebaseAuth.instance.currentUser!.uid);
            _login.updateUser(user);
          }
          Get.off(() => DashboardPage());
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
        body: Center(
      child: SvgPicture.asset(
        "img/illustration.svg",
        fit: BoxFit.contain,
      ),
    ));
  }
}
