import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourismapp/models/trip_model.dart';

import '../utils/colors.dart';
import '../widgets/large_txt.dart';
import '../widgets/simple_txt.dart';

class TripPage extends StatefulWidget {
  final bool isGuide;
  final TripModel trip;

  const TripPage(this.trip, {Key? key, this.isGuide = false}) : super(key: key);

  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  List list = [1, 2];

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
                      itemCount: widget.trip.images.length,
                      pagination: SwiperPagination(),
                      itemBuilder: (BuildContext context, int index) {
                        return CachedNetworkImage(
                          imageUrl: widget.trip.images[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            widthFactor: 1,
                            heightFactor: 1,
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.image_not_supported,
                            size: 60.0,
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.75),
                          ),
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
                        Expanded(child: AppLargeText(widget.trip.title, color: AppColors.onBackground)),
                        SizedBox(width: 10.0),
                        // Column(
                        //   children: [
                        AppLargeText(widget.trip.estimatedCost.toString(), size: 24.0, color: AppColors.secondary),
                        //     Row(
                        //       children: [
                        //         RatingBar.builder(
                        //           initialRating: 3,
                        //           minRating: 0,
                        //           direction: Axis.horizontal,
                        //           allowHalfRating: true,
                        //           itemCount: 5,
                        //           itemSize: 20.0,
                        //           itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                        //           itemBuilder: (context, _) => Icon(Icons.star, color: AppColors.starColor),
                        //           onRatingUpdate: (double value) {},
                        //         ),
                        //         SizedBox(width: 5.0),
                        //         AppText("(4.0)", color: AppColors.primary)
                        //       ],
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      children: [
                        Icon(Icons.location_city, color: AppColors.primary),
                        SizedBox(width: 5),
                        AppText("${widget.trip.location}, Pakistan", color: AppColors.onBackground),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    AppLargeText("Description", size: 20.0),
                    SizedBox(height: 5.0),
                    AppText(widget.trip.description, size: 10.0),
                    SizedBox(height: 20.0),
                    Center(child: AppLargeText("Itinerary", size: 20.0)),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: widget.trip.itinerary.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: index != list.length - 1 ? 15.0 : 0.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          //Implement this
                          //if(trip.length>1)
                          AppText('Day ${index + 1}', weight: FontWeight.w600),
                          SizedBox(height: 10.0),
                          Table(
                            border: TableBorder.all(color: index % 2 == 0 ? AppColors.primary : AppColors.secondaryVariant),
                            columnWidths: {0: FlexColumnWidth(0.35)},
                            children: widget.trip.itinerary[index]!
                                .map((e) => TableRow(
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: AppText(e.time.toString()),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: AppText(e.description ?? ""),
                                          ),
                                        ),
                                      ],
                                    ))
                                .toList(),
                          ),
                        ]),
                      ),
                    ),
                    // Row(
                    //   children: [
                    // LikeButton(
                    //   size: 40.0,
                    //   circleColor: CircleColor(start: AppColors.primary, end: AppColors.secondary),
                    //   bubblesColor: BubblesColor(dotPrimaryColor: AppColors.primary, dotSecondaryColor: AppColors.secondary),
                    //   likeBuilder: (bool isLiked) {
                    //     return Icon(
                    //       Icons.favorite,
                    //       color: isLiked ? AppColors.secondary : AppColors.secondary.withOpacity(0.45),
                    //       size: 40.0,
                    //     );
                    //   },
                    // ),
                    // SizedBox(width: 10.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: !widget.isGuide
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 40.0,
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: AppText('Book Now', weight: FontWeight.w700),
                ),
              ),
            )
          : null,
    );
  }
}