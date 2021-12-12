import 'package:flutter/material.dart';
import 'package:tourismapp/widgets/card.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class AllGuidesPage extends StatelessWidget {
  const AllGuidesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppText("Guides")),
      body: GridView.builder(
        padding: EdgeInsets.all(20.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1.65 / 2,
        ),
        shrinkWrap: true,
        itemBuilder: (context, index) => GuideCard(onTap: () {}),
      ),
    );
  }
}
