import 'package:flutter/material.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class GuideCard extends StatelessWidget {
  final VoidCallback onTap;

  const GuideCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            color: AppColors.onBackground.withOpacity(0.05),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YSUyMHBlcnNvbnxlbnwwfHwwfHw%3D&w=1000&q=80',
                    fit: BoxFit.cover,),

                ),
                SizedBox(height: 5.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppText('Rachel Rose Robert Junior', maxLines: 1, height: 1.0,size: 16.0,weight: FontWeight.w600, overflow: TextOverflow.fade,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.place_outlined, size: 16.0, color: AppColors.secondary),
                            SizedBox(width: 5.0),
                            Expanded(child: AppText('Lahore', size: 14.0, maxLines: 2,color: AppColors.secondary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 5.0),
            child: Row(
              children: [
                Icon(Icons.star, size: 18.0, color: AppColors.primary),
                SizedBox(width: 2.5),
                Expanded(child: AppText('2.4', size: 14.0,color: AppColors.primary, weight: FontWeight.w600)),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  const PlaceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      height: 120.0,
      color: AppColors.onBackground.withOpacity(0.05),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Image.network(
              'https://cdn.britannica.com/14/75514-120-05A119F2/K2-district-Karakoram-Range-portion-Gilgit-Baltistan-region.jpg',
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
                  AppText('Title', maxLines: 1, height: 1.0,size: 16.0,weight: FontWeight.w600),
                  SizedBox(height: 5.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.place_outlined, size: 18.0, color: AppColors.secondary),
                      SizedBox(width: 5.0),
                      Expanded(child: AppText('Lahore', size: 14.0, maxLines: 2,color: AppColors.secondary)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
