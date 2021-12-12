import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourismapp/controllers/login_controller.dart';
import 'package:tourismapp/models/attraction_model.dart';
import 'package:tourismapp/models/tourist_model.dart';
import 'package:tourismapp/models/trip_model.dart';
import 'package:tourismapp/services/database.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/widgets/large_txt.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

import 'home.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final LoginController _login = Get.find();

  @override
  void initState() {
    _tabController = TabController(length: AttractionType.values.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            AppLargeText("Favourite Attractions", centerAlign: false, size: 18.0),
            SizedBox(height: 20.0),
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  labelPadding: const EdgeInsets.only(left: 20, right: 20),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  labelColor: Theme.of(context).colorScheme.onBackground,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  indicator: CircleTabIndicator(color: AppColors.primary, radius: 4),
                  tabs: AttractionType.values.map((e) => Tab(text: "${e}s")).toList(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 2.5),
              height: 300,
              child: FutureBuilder<List<AttractionModel>>(
                  future: Database.getAttractions((_login.user! as TouristModel).favAttractionsIds),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: AppText(snapshot.error.toString()));
                    }
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    List<AttractionModel> trips = snapshot.data!;
                    if (trips.isEmpty) {
                      return Center(child: AppText("No Attractions found."));
                    }
                    return TabBarView(
                        controller: _tabController,
                        children: AttractionType.values
                            .map((e) => TabView(trips.where((element) => element.type == e).toList()))
                            .toList());
                  }),
            ),
            SizedBox(height: 20.0),
            Divider(height: 1.0,thickness: 1.0),
            AppLargeText("Trips", centerAlign: false, size: 18.0),
            SizedBox(height: 20.0),
            Expanded(
              child: FutureBuilder<List<TripModel>>(
                  future: Database.getTrips(_login.user!.tripsIds),
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
                        itemCount: _login.user!.tripsIds.length,
                        itemBuilder: (context, index) => TripTile(trips[index]));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class TripTile extends StatelessWidget {
  final TripModel trip;

  const TripTile(this.trip, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0.0),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: CachedNetworkImage(
                imageUrl: trip.images.first,
                imageBuilder: (context, imageProvider) => CircleAvatar(backgroundImage: imageProvider),
                placeholder: (context, url) => CircularProgressIndicator(strokeWidth: 0.5),
                errorWidget: (context, url, error) =>
                    Icon(Icons.person, color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            title: AppText(trip.title, maxLines: 1, overflow: TextOverflow.fade),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(trip.guideName, size: 12.0, maxLines: 1, overflow: TextOverflow.ellipsis),
                AppText(trip.guideNumber, size: 12.0, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
            trailing: Icon(Icons.arrow_right, color: Theme.of(context).colorScheme.primary),
          ),
          Divider(height: 10.0, color: Theme.of(context).colorScheme.primary),
        ],
      ),
    );
  }
}
