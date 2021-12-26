import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourismapp/controllers/login_controller.dart';
import 'package:tourismapp/models/trip_model.dart';
import 'package:tourismapp/pages/guide/add_trip/add_trip.dart';
import 'package:tourismapp/services/database.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/widgets/image_place_holder.dart';
import 'package:tourismapp/widgets/large_txt.dart';
import 'package:tourismapp/widgets/simple_txt.dart';
import 'package:tourismapp/widgets/trip_card.dart';

import '../../profile.dart';

class GuideHomePage extends StatefulWidget {
  const GuideHomePage({Key? key}) : super(key: key);

  @override
  _GuideHomePageState createState() => _GuideHomePageState();
}

class _GuideHomePageState extends State<GuideHomePage> {
  final LoginController _login = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddTripPage()),
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: addItems, child: AppLargeText("Packages")),
                  InkWell(
                    onTap: () => Get.to(() => ProfilePage()),
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      elevation: 4.0,
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(25.0),
                      child: GetBuilder<LoginController>(
                        builder: (context) {
                          if (_login.user!.imageUrl.isEmpty)
                            return SizedBox(width: 50.0, height: 50.0, child: ImagePlaceHolder(_login.user!.initials));
                          return CachedNetworkImage(
                            imageUrl: _login.user!.imageUrl,
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => ImagePlaceHolder(_login.user!.initials),
                            errorWidget: (context, url, error) => ImagePlaceHolder(_login.user!.initials),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: FutureBuilder<List<TripModel>>(
                    future: Database.getTrips(_login.user!.tripsIds),
                    builder: (context, snapshot) {
                      print(snapshot);
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
                      return ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: trips.length,
                        itemBuilder: (context, index) => TripCard(trips[index]),
                        separatorBuilder: (BuildContext context, int index) => SizedBox(height: 30.0),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addItems() {}
}
