import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourismapp/controllers/login_controller.dart';
import 'package:tourismapp/models/booking_model.dart';
import 'package:tourismapp/services/database.dart';
import 'package:tourismapp/widgets/booking_tile.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class GuideBookingsPage extends StatelessWidget {
  GuideBookingsPage({Key? key}) : super(key: key);
  final LoginController _login = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.25,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: AppText('Bookings', color: Theme.of(context).colorScheme.primary),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
        child: FutureBuilder<List<BookingModel>>(
            future: Database.getBookings(_login.user!.tripsIds),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: AppText(snapshot.error.toString()));
              }
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              List<BookingModel> bookings = snapshot.data!;
              if (bookings.isEmpty) {
                return Center(child: AppText("No bookings found."));
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: bookings.length,
                itemBuilder: (context, index) => BookingTile(bookings[index]),
              );
            }),
      ),
    );
  }
}
