import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../settings.dart';
import 'navpages/favourite.dart';
import 'navpages/home.dart';
import 'navpages/search.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final WebView eShop = WebView(javascriptMode: JavascriptMode.unrestricted, initialUrl: 'https://decentshops.com/');

  late final List<Widget> pages;
  int cIndex = 0;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    } else {
      WebView.platform = CupertinoWebView();
    }
    pages = [
      HomePage(),
      FavouritePage(),
      SearchPage(),
      SafeArea(child: eShop),
      SettingsPage(),
    ];
  }

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
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.blueGrey.withOpacity(0.5),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12.0,
        unselectedFontSize: 10.0,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Favourite", icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(label: "Search", icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: "E-Shop", icon: Icon(Icons.local_mall)),
          BottomNavigationBarItem(label: "Setting", icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}