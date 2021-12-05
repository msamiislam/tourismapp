import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/widgets/app_button.dart';
import 'package:tourismapp/widgets/large_txt.dart';
import 'package:tourismapp/widgets/responsive_button.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("img/mountain.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Positioned(
                top: 310,
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    right: 20,
                    left: 20,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppLargeText(
                            text: "Lahore",
                            color: Colors.black,
                          ),
                          AppLargeText(text: "PKR 8000", color: AppColors.mainTextColor),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.location_city,
                            color: AppColors.mainColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          AppText(
                            text: "Lahore, Pakistan",
                            color: AppColors.textColor1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          Wrap(
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: AppColors.starColor,
                              );
                            }),
                          ),
                          SizedBox(width: 10),
                          AppText(
                            text: "(4.0)",
                            color: AppColors.textColor2,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      AppLargeText(text: "People"),
                      SizedBox(
                        height: 5,
                      ),
                      AppText(text: "Number of people in your group"),
                      SizedBox(
                        height: 10,
                      ),

                      //it will help to generate number of buttons for members
                      Wrap(
                          children: List.generate(5, (index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: AppButtons(
                              size: 50,
                              backgroundColor: selectedIndex == index ? Colors.black : AppColors.buttonBackground,
                              borderColor: selectedIndex == index ? Colors.black : AppColors.buttonBackground,
                              color: selectedIndex == index ? Colors.white : Colors.black,
                              text: (index + 1).toString(),
                              //for icon use in button
                              //icon: Icons.favourite_border,
                              //isIcon: true,
                            ),
                          ),
                        );
                      })),
                      SizedBox(height: 20),

                      //description heading and text
                      AppLargeText(
                        text: "Description",
                        size: 20,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      AppText(
                        text:
                            "Packed with historic landmarks, bustling eateries, and manicured parks, the vibrant city of Lahore exudes culture at every corner. From soaring minarets and colorful facades to street-level stalls selling flavorful Punjabi favorites, the increasingly cosmopolitan city radiates with energy.",
                        size: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )),
            //at bottom wishlist button and book now button
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    AppButtons(
                      size: 4,
                      backgroundColor: AppColors.textColor2,
                      borderColor: Colors.white,
                      color: AppColors.textColor2,
                      isIcon: true,
                      icon: Icons.favorite_border,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ResponsiveButton(
                      isResponsive: true,
                    ),
                  ],
                )),
            Positioned(
                left: 20,
                top: 70,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Icon(Icons.arrow_back),
                )),
          ],
        ),
      ),
    );
  }
}
