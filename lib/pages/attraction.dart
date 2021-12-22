import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:tourismapp/controllers/login_controller.dart';
import 'package:tourismapp/models/attraction_model.dart';
import 'package:tourismapp/models/hotel_model.dart';
import 'package:tourismapp/models/mall_model.dart';
import 'package:tourismapp/models/restaurant_model.dart';
import 'package:tourismapp/models/tourist_model.dart';
import 'package:tourismapp/services/database.dart';
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
  final LoginController _login = Get.find();
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
      return (widget.attraction as MallModel).link;
    }
    if (widget.attraction.type == AttractionType.hotel) {
      return (widget.attraction as HotelModel).link;
    }
    if (widget.attraction.type == AttractionType.restaurant) {
      return (widget.attraction as RestaurantModel).link;
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
                        return CachedNetworkImage(
                          imageUrl: widget.attraction.images[index],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppLargeText("Description", size: 20.0),
                        LikeButton(
                          isLiked: (_login.user as TouristModel).favAttractionsIds.contains(widget.attraction.id),
                          size: 30.0,
                          circleColor: CircleColor(start: AppColors.primary, end: AppColors.secondary),
                          bubblesColor: BubblesColor(dotPrimaryColor: AppColors.primary, dotSecondaryColor: AppColors.secondary),
                          onTap: (liked) async {
                            TouristModel tourist = (_login.user as TouristModel);
                            List<String> ids = tourist.favAttractionsIds;
                            !liked ? ids.add(widget.attraction.id) : ids.remove(widget.attraction.id);
                            _login.updateUser(TouristModel(
                                id: tourist.id,
                                imageUrl: tourist.imageUrl,
                                firstName: tourist.firstName,
                                lastName: tourist.lastName,
                                email: tourist.email,
                                bloodGroup: tourist.bloodGroup,
                                phone: tourist.phone,
                                address: tourist.address,
                                dob: tourist.dob,
                                gender: tourist.gender,
                                favAttractionsIds: ids));
                            await Database.updateFavAttraction(tourist);
                            return !liked;
                          },
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.favorite,
                              color: isLiked ? AppColors.secondary : AppColors.secondary.withOpacity(0.45),
                              size: 30.0,
                            );
                          },
                        ),
                      ],
                    ),
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
