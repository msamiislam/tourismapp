import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourismapp/pages/guide/add_trip/add_trip_controller.dart';
import 'package:tourismapp/pages/guide/add_trip/trip_itinerary.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class TripDaysPage extends StatelessWidget {
  final AddTripController _tripController = Get.find();
  TripDaysPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(child: AppText('Step 2 of 2', size: 16.0, weight: FontWeight.w600)),
          SizedBox(width: 10.0),
        ],
      ),
      body: PageView.builder(
        controller: _tripController.pageController,
        itemCount: _tripController.daysCount,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => TripItineraryPage(),
      ),
    );
  }
}
