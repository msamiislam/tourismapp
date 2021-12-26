import 'package:tourismapp/models/contact_model.dart';

abstract class Constants {
  static const String cabPackageName = "com.ubercab";
  static const String trainPackageName = "pk.gov.railways";
  static const String planePackageName = "com.piac.thepiaapp.android";
  static const String busPackageName = "com.app.daewoo.miles";

  static const Map<String, List<ContactModel>> cityContacts = {
    "Islamabad": [
      ContactModel(name: "Rescue", number: "1122"),
      ContactModel(name: "Rescue", number: "1124"),
      ContactModel(name: "Rescue", number: "1122"),
    ],
    "Lahore": [],
    "Karachi": [],
    "Sialkot": [],
    "Waziristan": [],
    "Kashmir": [],
  };

  static const List<String> states = [
    "Punjab",
    "Sindh",
    "KPK",
    "Azad Kashmir",
    "Balochistan",
    "FATA",
  ];
}
