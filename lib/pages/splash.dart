import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../pages/dashboard.dart';
import '../pages/login.dart';
import '../pages/welcome.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      bool openedApp = GetStorage().read<bool>("opened_app") ?? false;
      if (openedApp) {
        if (FirebaseAuth.instance.currentUser == null) {
          Get.offAll(() => LoginPage());
        } else {
          Get.off(() => DashboardPage());
        }
      } else {
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
