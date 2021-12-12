import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourismapp/models/trip_model.dart';
import 'package:tourismapp/pages/detail.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class TripCard extends StatelessWidget {
  final TripModel trip;

  const TripCard(this.trip, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => DetailPage(isGuide: true)),
      child: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height / 3,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: CachedNetworkImage(
              imageUrl: trip.images.first,
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
          ),
          Container(
            height: Get.height / 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black54],
              ),
            ),
          ),
          Positioned(
            right: 15.0,
            left: 15.0,
            bottom: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  trip.title,
                  color: Theme.of(context).colorScheme.onPrimary,
                  weight: FontWeight.bold,
                ),
                AppText(trip.estimatedCost.toString(), color: Theme.of(context).colorScheme.onPrimary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
