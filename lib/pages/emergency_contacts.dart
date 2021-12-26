import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tourismapp/models/contact_model.dart';
import 'package:tourismapp/utils/constants.dart';
import 'package:tourismapp/utils/launcher.dart';
import 'package:tourismapp/widgets/large_txt.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class EmergencyContactsPage extends StatefulWidget {
  const EmergencyContactsPage({Key? key}) : super(key: key);

  @override
  State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {


  String? selectedCity = "Lahore";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Emergency Contacts")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppLargeText("Select a city", centerAlign: false, size: 18.0),
            DropdownButton<String>(
              value: selectedCity,
              isExpanded: true,
              onChanged: (newCity) => setState(() => selectedCity = newCity),
              items: Constants.cityContacts.keys.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
            ),
            SizedBox(height: 10.0),
            AppLargeText("Contacts", centerAlign: false, size: 16.0),
            Expanded(
              child: ListView(
                children: (Constants.cityContacts[selectedCity] ?? <ContactModel>[])
                    .map((e) => ListTile(
                          title: AppText(e.name),
                          trailing: AppText(e.number),
                          onTap: () async {
                            if (await Launcher.canDial(e.number)) {
                              Launcher.openDialer(e.number);
                            } else {
                              Fluttertoast.showToast(msg: "Unable to open dialer");
                            }
                          },
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
