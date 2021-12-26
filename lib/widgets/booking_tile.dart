import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tourismapp/models/booking_model.dart';

import 'simple_txt.dart';

class BookingTile extends StatelessWidget {
  final BookingModel booking;

  const BookingTile(this.booking, {Key? key}) : super(key: key);

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
                imageUrl: booking.tourist.imageUrl,
                imageBuilder: (context, imageProvider) => CircleAvatar(backgroundImage: imageProvider),
                placeholder: (context, url) => CircularProgressIndicator(strokeWidth: 0.5),
                errorWidget: (context, url, error) =>
                    Icon(Icons.person, color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            title: AppText(booking.tourist.name, maxLines: 1, overflow: TextOverflow.fade),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(booking.tourist.phone, size: 12.0, maxLines: 1, overflow: TextOverflow.ellipsis),
                AppText(booking.trip.title, size: 12.0, maxLines: 1, overflow: TextOverflow.ellipsis),
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
