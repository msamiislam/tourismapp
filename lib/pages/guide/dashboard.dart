import 'package:flutter/material.dart';
import 'package:tourismapp/pages/guide/navpages/bookings.dart';
import 'package:tourismapp/pages/settings.dart';

import 'navpages/home.dart';

class GuideDashboardPage extends StatefulWidget {
  const GuideDashboardPage({Key? key}) : super(key: key);

  @override
  _GuideDashboardPageState createState() => _GuideDashboardPageState();
}

class _GuideDashboardPageState extends State<GuideDashboardPage> {
  List pages = [
    GuideHomePage(),
    GuideBookingsPage(),
    SettingsPage(),
  ];
  int cIndex = 0;

  void onTapButton(int index) {
    setState(() => cIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[cIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        onTap: onTapButton,
        currentIndex: cIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.blueGrey.withOpacity(0.5),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12.0,
        unselectedFontSize: 10.0,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(label: "Trips", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Bookings", icon: Icon(Icons.notifications)),
          // BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: "Setting", icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
