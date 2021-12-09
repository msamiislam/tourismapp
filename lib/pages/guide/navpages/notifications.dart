import 'package:flutter/material.dart';
import 'package:tourismapp/widgets/booking_tile.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class GuideNotificationsPage extends StatelessWidget {
  const GuideNotificationsPage({Key? key}) : super(key: key);

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
        child: SingleChildScrollView(
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => BookingTile(
              onTap: () {},
              touristImage: '',
              touristName: 'John Mendes',
              tripTitle: '5 days full taillored Hunza trip',
            ),
          ),
        ),
      ),
    );
  }
}
