import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tourismapp/models/guide_model.dart';
import 'package:tourismapp/models/trip_model.dart';
import 'package:tourismapp/services/database.dart';
import 'package:tourismapp/utils/launcher.dart';
import 'package:tourismapp/widgets/image_place_holder.dart';
import 'package:tourismapp/widgets/simple_txt.dart';
import 'package:tourismapp/widgets/trip_card.dart';

class GuideProfilePage extends StatelessWidget {
  final GuideModel guide;

  const GuideProfilePage(this.guide, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText('Guide Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15.0),
                width: 150.0,
                height: 150.0,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.secondary),
                child: CachedNetworkImage(
                  imageUrl: guide.imageUrl,
                  errorWidget: (context, url, error) => ImagePlaceHolder(guide.initials, fontSize: 20.0),
                  placeholder: (context, url) => ImagePlaceHolder(guide.initials, fontSize: 20.0),
                  fit: BoxFit.cover,
                ),
              ),
              AppText('${guide.firstName} ${guide.lastName}',
                  size: 16.0, color: Theme.of(context).colorScheme.primary, weight: FontWeight.w500),
              SizedBox(height: 15.0),
              ListTile(
                leading: Icon(Icons.phone_outlined),
                title: AppText(guide.phone),
                trailing: InkWell(
                    onTap: () {
                      Launcher.chat(guide.phone);
                    },
                    child: Icon(FontAwesomeIcons.whatsapp)),
              ),
              ListTile(
                leading: Icon(Icons.mail_outlined),
                title: AppText(guide.email),
              ),
              ListTile(
                leading: Icon(Icons.location_city),
                title: AppText('${guide.state} - ${guide.city}'),
              ),
              ListTile(
                leading: Icon(Icons.store),
                title: AppText(guide.companyName),
              ),
              FutureBuilder<List<TripModel>>(
                  future: Database.getTrips(guide.tripsIds),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    List<TripModel> trips = snapshot.data!;
                    // if (trips.isEmpty) return SizedBox();
                    return Column(
                      children: [
                        SizedBox(height: 15.0),
                        AppText('Trips', size: 16.0, weight: FontWeight.bold),
                        SizedBox(height: 15.0),
                        ...trips.map((e) => TripCard(e))
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
