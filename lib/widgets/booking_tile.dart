import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'simple_txt.dart';

class BookingTile extends StatelessWidget {
  final String touristImage;
  final String touristName;
  final String tripTitle;
  final VoidCallback onTap;

  const BookingTile(
      {Key? key, required this.touristImage, required this.touristName, required this.tripTitle, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0.0),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: CachedNetworkImage(
                imageUrl: touristImage,
                imageBuilder: (context, imageProvider) => CircleAvatar(backgroundImage: imageProvider),
                placeholder: (context, url) => CircularProgressIndicator(strokeWidth: 0.5),
                errorWidget: (context, url, error) => Icon(Icons.person, color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            title: AppText(
              touristName,
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
            subtitle: AppText(
              tripTitle,
              size: 12.0,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(Icons.arrow_right, color: Theme.of(context).colorScheme.primary),
          ),
          Divider(height: 0.0, color: Theme.of(context).colorScheme.primary),
        ],
      ),
    );
  }
}
