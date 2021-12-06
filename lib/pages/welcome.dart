import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tourismapp/pages/registration_personal.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/widgets/large_txt.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int index = 0;
  List images = [
    "welcome_01.png",
    "welcome_02.png",
    "welcome_03.png",
  ];
  List text = [
    "Trips",
    "Explorer",
    "Adventure",
  ];

  @override
  void initState() {
    GetStorage().write("opened_app", true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: images.length + 1,
        physics: index == images.length ? NeverScrollableScrollPhysics() : null,
        onPageChanged: (index) => setState(() => this.index = index),
        itemBuilder: (_, index) {
          if (index == images.length) {
            return RegistrationPersonalPage();
          } else {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("img/" + images[index]), fit: BoxFit.cover),
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText( text[index]),
                        AppText( "Northern Areas", size: 30),
                        SizedBox(height: 22),
                        SizedBox(
                          width: 260,
                          child: AppText(

                                "We will provide you the best experience in northern areas of Pakistan. Once you try, you will book in sequence. This is our promise.",
                            color: AppColors.textColor2,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: List.generate(images.length, (indexDots) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 3),
                          width: 8,
                          height: index == indexDots ? 25 : 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.mainColor,
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
