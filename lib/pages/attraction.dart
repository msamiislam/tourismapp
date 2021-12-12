import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tourismapp/models/attraction_model.dart';
import 'package:tourismapp/models/hotel_model.dart';
import 'package:tourismapp/models/mall_model.dart';
import 'package:tourismapp/models/restaurant_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/colors.dart';
import '../widgets/large_txt.dart';
import '../widgets/simple_txt.dart';

class AttractionPage extends StatefulWidget {
  final AttractionModel attraction;

  const AttractionPage(this.attraction, {Key? key}) : super(key: key);

  @override
  _AttractionPageState createState() => _AttractionPageState();
}

class _AttractionPageState extends State<AttractionPage> {
  int selectedIndex = -1;

  String getPhone() {
    if (widget.attraction.type == AttractionType.mall) {
      return (widget.attraction as MallModel).phone;
    }
    if (widget.attraction.type == AttractionType.hotel) {
      return (widget.attraction as HotelModel).phone;
    }
    if (widget.attraction.type == AttractionType.restaurant) {
      return (widget.attraction as RestaurantModel).phone;
    }
    return "";
  }

  String getLink() {
    if (widget.attraction.type == AttractionType.mall) {
      return (widget.attraction as MallModel).phone;
    }
    if (widget.attraction.type == AttractionType.hotel) {
      return (widget.attraction as HotelModel).phone;
    }
    if (widget.attraction.type == AttractionType.restaurant) {
      return (widget.attraction as RestaurantModel).phone;
    }
    return "";
  }

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
                      itemCount: widget.attraction.images.length,
                      pagination: SwiperPagination(),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          widget.attraction.images[index],
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
                        Expanded(child: AppLargeText(widget.attraction.name, color: AppColors.onBackground)),
                        SizedBox(width: 10.0),
                        Column(
                          children: [
                            AppLargeText("PKR 8,000", size: 24.0, color: AppColors.secondary),
                            Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: widget.attraction.rating,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  ignoreGestures: true,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                                  itemBuilder: (context, _) => Icon(Icons.star, color: AppColors.starColor),
                                  onRatingUpdate: (double value) {},
                                ),
                                SizedBox(width: 5.0),
                                AppText("(${widget.attraction.rating})", color: AppColors.primary)
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
                        AppText("${widget.attraction.city}, Pakistan", color: AppColors.onBackground),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    AppLargeText("Description", size: 20.0),
                    SizedBox(height: 5.0),
                    AppText(widget.attraction.description, size: 10.0),
                    SizedBox(height: 20.0),
                    if (widget.attraction.type != AttractionType.place) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText("Phone ", size: 15.0),
                          SizedBox(width: 5.0),
                          AppText(getPhone(), size: 10.0),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText("Link ", size: 15.0),
                          SizedBox(width: 5.0),
                          InkWell(
                            onTap: () async {
                              if (await launch((widget.attraction as MallModel).link)) {
                                Fluttertoast.showToast(msg: "Unable to open link.");
                              }
                            },
                            child: AppText(
                              getLink(),
                              size: 10.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
