import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tourismapp/controllers/login_controller.dart';
import 'package:tourismapp/pages/login.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> currencies = ["PKR", "USD"];
  List<String> distances = ["KM", "MI"];
  List<String> temperatures = ["C", "F"];
  String currency = GetStorage().read("currency") ?? "PKR";
  String distance = GetStorage().read("distance") ?? "KM";
  String temperature = GetStorage().read("temperature") ?? "C";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: Get.mediaQuery.viewPadding.top, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            color: Theme.of(context).colorScheme.secondary,
            elevation: 4.0,
            child: Image.asset("img/logo.png", width: 100.0, height: 100.0),
            type: MaterialType.circle,
          ),
          SizedBox(height: 20.0),
          AppText("Tourism", size: 20.0, weight: FontWeight.w500, textAlign: TextAlign.center),
          SizedBox(height: 10.0),
          AppText(
            "Lorem ipsum is a dummy text used for industrial purposes.",
            size: 16.0,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                "Theme",
                size: 16.0,
                weight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              DropdownButton<AdaptiveThemeMode>(
                  value: AdaptiveTheme.of(context).mode,
                  onChanged: (value) async {
                    AdaptiveTheme.of(context).setThemeMode(value!);
                    setState(() {});
                  },
                  items: AdaptiveThemeMode.values
                      .map((e) => DropdownMenuItem(
                            child: Text(e.name),
                            value: e,
                          ))
                      .toList()),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                "Currency",
                size: 16.0,
                weight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              DropdownButton<String>(
                  value: currency,
                  onChanged: (value) async {
                    setState(() => currency = value ?? currency);
                    await GetStorage().write("currency", currency);
                  },
                  items: currencies
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList()),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                "Distance",
                size: 16.0,
                weight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              DropdownButton<String>(
                  value: distance,
                  onChanged: (value) async {
                    setState(() => distance = value ?? distance);
                    await GetStorage().write("distance", distance);
                  },
                  items: distances
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList()),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                "Temperature",
                size: 16.0,
                weight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
              DropdownButton<String>(
                  value: temperature,
                  onChanged: (value) async {
                    setState(() => temperature = value ?? temperature);
                    await GetStorage().write("temperature", temperature);
                  },
                  items: temperatures
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList()),
            ],
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                LoginController login = Get.find();
                login.updateUser(null);
                Get.offAll(() => LoginPage());
              },
              child: AppText("Logout"))
        ],
      ),
    ));
  }
}
