import 'package:flutter/material.dart';
import 'package:tourismapp/widgets/package_card.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class GuideHomePage extends StatefulWidget {
  const GuideHomePage({Key? key}) : super(key: key);

  @override
  _GuideHomePageState createState() => _GuideHomePageState();
}

class _GuideHomePageState extends State<GuideHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: AppText('All Packages'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [
              ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return PackageCard(
                    title: 'Badshahi Masjid full tailored 1 day trip',
                    price: 'PKR 8000',
                    image: 'https://archaeology.punjab.gov.pk/system/files/2_36.jpg',
                  );
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(height: 15.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
