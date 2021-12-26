import 'package:url_launcher/url_launcher.dart';

abstract class Launcher {
  static Future<void> openDialer(String phoneNumber) async {
    await launch("tel:$phoneNumber");
  }

  static Future<bool> canDial(String phoneNumber) async {
    return await canLaunch("tel:$phoneNumber");
  }

  static Future<bool> chat(String phoneNumber) async {
    String url = "https://api.whatsapp.com/send?phone=92${phoneNumber.substring(1)}";
    try {
      return await launch(url);
    } catch (_) {
      return false;
    }
  }
}
