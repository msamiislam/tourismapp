import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:tourismapp/models/attraction_model.dart';
import 'package:tourismapp/models/guide_model.dart';
import 'package:tourismapp/pages/attraction.dart';
import 'package:tourismapp/pages/tourist/guide.dart';

import '../utils/colors.dart';
import '../widgets/simple_txt.dart';
import 'image_place_holder.dart';

class GuideCard extends StatelessWidget {
  final GuideModel guide;

  const GuideCard(this.guide, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => GuidePage(guide)),
      child: Stack(
        children: [
          Container(
            color: AppColors.onBackground.withOpacity(0.05),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: guide.imageUrl.isURL
                      ? CachedNetworkImage(
                          imageUrl: guide.imageUrl,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) =>
                              ImagePlaceHolder(guide.initials, fontSize: 20.0),
                          errorWidget: (context, url, error) => ImagePlaceHolder(guide.initials, fontSize: 20.0),
                        )
                      : ImagePlaceHolder(guide.initials, fontSize: 20.0),
                ),
                SizedBox(height: 5.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppText(
                          guide.name,
                          maxLines: 1,
                          height: 1.0,
                          size: 16.0,
                          weight: FontWeight.w600,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.left,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.place_outlined, size: 16.0, color: AppColors.secondary),
                            SizedBox(width: 5.0),
                            Expanded(child: AppText(guide.city, size: 14.0, maxLines: 2, color: AppColors.secondary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (false)
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 5.0),
              child: Row(
                children: [
                  Icon(Icons.star, size: 18.0, color: AppColors.primary),
                  SizedBox(width: 2.5),
                  Expanded(child: AppText('2.4', size: 14.0, color: AppColors.primary, weight: FontWeight.w600)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class AttractionCard extends StatelessWidget {
  final AttractionModel attraction;

  const AttractionCard(this.attraction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => AttractionPage(attraction)),
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(bottom: 10.0),
        height: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: AppColors.onBackground.withOpacity(0.05),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.network(
                attraction.images.first,
                fit: BoxFit.cover,
                height: 120.0,
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(attraction.name, maxLines: 1, height: 1.0, size: 16.0, weight: FontWeight.w600),
                        AppText(attraction.type, size: 14.0, maxLines: 2, color: AppColors.secondary),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.place_outlined, size: 18.0, color: AppColors.secondary),
                        SizedBox(width: 5.0),
                        Expanded(child: AppText(attraction.city, size: 14.0, maxLines: 2, color: AppColors.secondary)),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: attraction.rating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 14.0,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                          itemBuilder: (context, _) => Icon(Icons.star, color: AppColors.starColor),
                          onRatingUpdate: (double value) {},
                        ),
                        SizedBox(width: 5.0),
                        AppText(
                          "(${attraction.rating})",
                          color: AppColors.primary,
                          size: 12.0,
                        )
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      children: [
                        Icon(Icons.location_city, color: AppColors.primary),
                        SizedBox(width: 5),
                        AppText("Lahore, Pakistan", color: AppColors.onBackground),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
