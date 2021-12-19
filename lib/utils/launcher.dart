import 'package:url_launcher/url_launcher.dart';

abstract class Launcher {
  static Future<void> openDialer(String phoneNumber) async {
    await launch("tel:$phoneNumber");
  }

  static Future<bool> canDial(String phoneNumber) async {
    return await canLaunch("tel:$phoneNumber");
  }
}
