import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/widgets/large_txt.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 300,
                    child: Swiper(
                      itemCount: 3,
                      pagination: SwiperPagination(),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          "https://archaeology.punjab.gov.pk/system/files/2_36.jpg",
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                  IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: AppLargeText("Badshahi Masjid", color: AppColors.onBackground)),
                        SizedBox(width: 10.0),
                        Column(
                          children: [
                            AppLargeText("PKR 8,000", size: 24.0, color: AppColors.secondary),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                                  itemBuilder: (context, _) => Icon(Icons.star, color: AppColors.starColor),
                                  onRatingUpdate: (double value) {},
                                ),
                                SizedBox(width: 5.0),
                                AppText("(4.0)", color: AppColors.primary)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),

                    Row(
                      children: [
                        Icon(Icons.location_city, color: AppColors.primary),
                        SizedBox(width: 5),
                        AppText("Lahore, Pakistan", color: AppColors.onBackground),
                      ],
                    ),
                    SizedBox(height: 20.0),

                    // AppLargeText("People"),
                    // SizedBox(height: 5),
                    // AppText("Number of people in your group"),
                    // SizedBox(height: 10),

                    //it will help to generate number of buttons for members
                    // Wrap(
                    //     children: List.generate(5, (index) {
                    //   return InkWell(
                    //     onTap: () {
                    //       setState(() {
                    //         selectedIndex = index;
                    //       });
                    //     },
                    //     child: Container(
                    //       margin: const EdgeInsets.only(right: 10),
                    //       child: AppButtons(
                    //         size: 50,
                    //         backgroundColor: selectedIndex == index ? Colors.black : AppColors.buttonBackground,
                    //         borderColor: selectedIndex == index ? Colors.black : AppColors.buttonBackground,
                    //         color: selectedIndex == index ? Colors.white : Colors.black,
                    //         text: (index + 1).toString(),
                    //         //for icon use in button
                    //         //icon: Icons.favourite_border,
                    //         //isIcon: true,
                    //       ),
                    //     ),
                    //   );
                    // })),
                    // SizedBox(height: 20),

                    //description heading and text
                    AppLargeText("Description", size: 20.0),
                    SizedBox(height: 5.0),
                    AppText(
                        "Packed with historic landmarks, bustling eateries, and manicured parks, the vibrant city of Lahore exudes culture at every corner. From soaring minarets and colorful facades to street-level stalls selling flavorful Punjabi favorites, the increasingly cosmopolitan city radiates with energy.",
                        size: 10.0),
                    SizedBox(height: 20.0),

                    Center(child: AppLargeText("Itenary", size: 20.0)),
                    // SizedBox(height: 5.0),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Implement this
                            //if(trip.length>1)
                            AppText('Day ${index + 1}', weight: FontWeight.w600),
                            SizedBox(height: 10.0),
                            Table(
                              border: TableBorder.all(color: index % 2 == 0 ? AppColors.primary : AppColors.secondaryVariant),
                              columnWidths: {0: FlexColumnWidth(0.35)},
                              children: [
                                TableRow(
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: AppText('Time'),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: AppText('Details'),
                                      ),
                                    ),
                                  ],
                                ),
                                //for trips.length
                                for (int i = 0; i < 3; i++)
                                  TableRow(
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: AppText('10:00 am'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                                        child: AppText('Leave from the pickup point'),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        LikeButton(
                          size: 40.0,
                          circleColor: CircleColor(start: AppColors.primary, end: AppColors.secondary),
                          bubblesColor: BubblesColor(dotPrimaryColor: AppColors.primary, dotSecondaryColor: AppColors.secondary),
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.favorite,
                              color: isLiked ? AppColors.secondary : AppColors.secondary.withOpacity(0.45),
                              size: 40.0,
                            );
                          },
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: SizedBox(
                            height: 40.0,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: AppText('Book Now', weight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //at bottom wishlist button and book now button
              // Row(
              //   children: [
              //     AppButtons(
              //       size: 4,
              //       backgroundColor: AppColors.textColor2,
              //       borderColor: Colors.white,
              //       color: AppColors.textColor2,
              //       isIcon: true,
              //       icon: Icons.favorite_border,
              //     ),
              //     SizedBox(width: 20),
              //     ResponsiveButton(isResponsive: true),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
