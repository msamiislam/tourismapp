import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourismapp/models/guide_model.dart';
import 'package:tourismapp/models/trip_model.dart';
import 'package:tourismapp/services/database.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/widgets/image_place_holder.dart';
import 'package:tourismapp/widgets/large_txt.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

import 'navpages/favourite.dart';

class GuidePage extends StatefulWidget {
  final GuideModel guide;

  const GuidePage(this.guide, {Key? key}) : super(key: key);

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    print(widget.guide.imageUrl);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 300,
              width: Get.width,
              child: Stack(
                children: [
                  !widget.guide.imageUrl.isURL
                      ? ImagePlaceHolder(widget.guide.initials, fontSize: 20.0)
                      : CachedNetworkImage(
                          imageUrl: widget.guide.imageUrl,
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
                        ),
                  IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: AppLargeText(widget.guide.name, color: AppColors.onBackground)),
                      SizedBox(width: 10.0),
                      // Column(
                      //   children: [
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
                      AppText("${widget.guide.city}, ${widget.guide.state}", color: AppColors.onBackground),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  AppLargeText("Description", size: 20.0),
                  SizedBox(height: 5.0),
                  AppText(
                      "Packed with historic landmarks, bustling eateries, and manicured parks, the vibrant city of Lahore exudes culture at every corner. From soaring minarets and colorful facades to street-level stalls selling flavorful Punjabi favorites, the increasingly cosmopolitan city radiates with energy.",
                      size: 10.0),
                  SizedBox(height: 20.0),
                  AppLargeText("Trips", centerAlign: false, size: 18.0),
                  SizedBox(height: 20.0),
                  SizedBox(
                    height: 300.0,
                    child: FutureBuilder<List<TripModel>>(
                        future: Database.getTrips(widget.guide.tripsIds),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(child: AppText(snapshot.error.toString()));
                          }
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }
                          List<TripModel> trips = snapshot.data!;
                          if (trips.isEmpty) {
                            return Center(child: AppText("No trips found."));
                          }
                          return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: trips.length,
                              itemBuilder: (context, index) {
                                int days = trips[index].itinerary.length;
                                DateTime startTime = DateTime.parse(trips[index].id.replaceAll("id", ""));
                                DateTime endTime = startTime.add(Duration(days: days));
                                return TripTile(trips[index]);
                              });
                        }),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
