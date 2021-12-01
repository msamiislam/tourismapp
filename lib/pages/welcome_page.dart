import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourismapp/cubit/app_cubits.dart';
import 'package:tourismapp/widgets/large_txt.dart';
import 'package:tourismapp/widgets/responsive_button.dart';
import 'package:tourismapp/widgets/simple_txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tourismapp/misc/colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({ Key? key }) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images=[
    "welcome_01.png",
    "welcome_02.png",
    "welcome_03.png",
  ];
  List text=[
    "Trips",
    "Explorer",
    "Adventure",
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: images.length,
        itemBuilder: (_, index){
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "img/"+images[index]
                ), 
                fit: BoxFit.cover
                ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(text: text[index]),
                      AppText(text: "Northern Areas", size: 30,),
                      SizedBox(height: 22,),
                      Container(
                        width: 260,
                        child: AppText(
                          text: "We will povide you the bext experience in northern areas of Pakistan. Once you try, you will book in sequence. This is our promise.",
                          color: AppColors.textColor2,
                          size: 14,
                        ),
                      ),
                      SizedBox(height: 22,),
                      GestureDetector(
                        onTap: (){
                          BlocProvider.of<AppCubits>(context).mainPage();
                        },
                        child: Container(
                          width: 200,
                          child: Row(children:[ResponsiveButton(width: 120,)], )
                          ),
                      ),
                    ],
                  ),
                  Column(
                    children: List.generate(3, (indexDots){
                      return Container(
                        margin: const EdgeInsets.only(bottom: 3),
                        width: 8,
                        height: index==indexDots?25:8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.mainColor,
                        ),
                      );
                    }),

                  )
                ],
              ),
            )
          );
      })
    );
  }
}