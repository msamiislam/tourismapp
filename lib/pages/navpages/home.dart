import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tourismapp/models/attraction_model.dart';
import 'package:tourismapp/models/hotel_model.dart';
import 'package:tourismapp/models/mall_model.dart';
import 'package:tourismapp/models/place_model.dart';
import 'package:tourismapp/models/restaurant_model.dart';
import 'package:tourismapp/pages/all_guides.dart';
import 'package:tourismapp/services/database.dart';

import '../../controllers/login_controller.dart';
import '../../pages/profile.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/image_place_holder.dart';
import '../../widgets/large_txt.dart';
import '../../widgets/simple_txt.dart';
import '../attraction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final LoginController _login = LoginController();
  final List<AttractionModel> attractions = Get.find(tag: "attractions");

  Map<String, Map<String, String>> travelImages = {
    "Cab": {
      "image": "cab.png",
      "link": Constants.cabPackageName,
    },
    "Train": {
      "image": "train.png",
      "link": Constants.trainPackageName,
    },
    "Plane": {
      "image": "airplane.png",
      "link": Constants.planePackageName,
    },
    "Bus": {
      "image": "bus.png",
      "link": Constants.busPackageName,
    },
  };
  Map<String, Map<String, String>> guiderImages = {
    "Kareem Dad": {
      "image": "cab.png",
    },
    "Saif ur Rehman": {
      "image": "train.png",
    },
    "Arooj Fatima": {
      "image": "airplane.png",
    },
    "Phola Cheeda": {
      "image": "bus.png",
    },
  };

  @override
  void initState() {
    _tabController = TabController(length: AttractionType.values.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            //upper Menu bar icon + image
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap: addItems, child: AppLargeText("Discover")),
                  InkWell(
                    onTap: () => Get.to(() => ProfilePage()),
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      elevation: 4.0,
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(25.0),
                      child: GetBuilder<LoginController>(
                        builder: (context) {
                          return CachedNetworkImage(
                            imageUrl: _login.user!.imageUrl,
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, progress) =>
                                ImagePlaceHolder(_login.user!.initials),
                            errorWidget: (context, url, error) => ImagePlaceHolder(_login.user!.initials),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  labelPadding: const EdgeInsets.only(left: 20, right: 20),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  indicator: CircleTabIndicator(color: AppColors.primary, radius: 4),
                  tabs: AttractionType.values.map((e) => Tab(text: "${e}s")).toList(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 2.5, left: 20),
              height: 300,
              child: TabBarView(
                  controller: _tabController,
                  children: AttractionType.values
                      .map((e) => TabView(attractions.where((element) => element.type == e).toList()))
                      .toList()),
            ),
            SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: AppLargeText("Explore Travels", size: 20),
            ),
            Container(
              height: 110,
              width: double.maxFinite,
              margin: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                itemCount: travelImages.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {
                      LaunchApp.openApp(
                        androidPackageName: travelImages.values.elementAt(index)["link"]!,
                        openStore: true,
                      );
                    },
                    child: ExploreItem(
                        image: travelImages.values.elementAt(index)["image"]!,
                        text: travelImages.keys.elementAt(index)),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLargeText("Explore Guiders", size: 20),
                  InkWell(
                      onTap: () => Get.to(() => AllGuidesPage()),
                      child: AppText("See all", color: AppColors.textColor1)),
                ],
              ),
            ),
            Container(
              height: 110,
              width: double.maxFinite,
              margin: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                itemCount: guiderImages.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {},
                    child: ExploreItem(
                        image: guiderImages.values.elementAt(index)["image"]!,
                        text: guiderImages.keys.elementAt(index)),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void addItems() async {
    await Database.addAttractions([
      ...List.generate(
          10,
          (i) => PlaceModel(
                id: "id$i${DateTime.now().microsecondsSinceEpoch}",
                name: "name$i",
                city: "city$i",
                address: "address$i",
                description: "description$i",
                images: List.generate(3, (index) => "https://picsum.photos/600?random=$index"),
                rating: (Random().nextInt(5) + ((i % 2 == 0) ? 0.5 : 0)),
              )),
      ...List.generate(
          10,
          (i) => MallModel(
                id: "id$i${DateTime.now().microsecondsSinceEpoch}",
                name: "name$i",
                city: "city$i",
                address: "address$i",
                description: "description$i",
                images: List.generate(3, (index) => "https://picsum.photos/600?random=$index"),
                phone: 'phone$i',
                link: 'link$i',
                rating: (Random().nextInt(5) + i % 2 == 0 ? 0.5 : 0),
              )),
      ...List.generate(
          10,
          (i) => RestaurantModel(
                id: "id$i${DateTime.now().microsecondsSinceEpoch}",
                name: "name$i",
                city: "city$i",
                address: "address$i",
                description: "description$i",
                images: List.generate(3, (index) => "https://picsum.photos/600?random=$index"),
                phone: 'phone$i',
                link: 'link$i',
                rating: (Random().nextInt(5) + i % 2 == 0 ? 0.5 : 0),
              )),
      ...List.generate(
          10,
          (i) => HotelModel(
                id: "id$i${DateTime.now().microsecondsSinceEpoch}",
                name: "name$i",
                city: "city$i",
                address: "address$i",
                description: "description$i",
                images: List.generate(3, (index) => "https://picsum.photos/600?random=$index"),
                phone: 'phone$i',
                link: 'link$i',
                stars: i + 1,
                rating: (Random().nextInt(5) + i % 2 == 0 ? 0.5 : 0),
              )),
    ]);
    Fluttertoast.showToast(msg: "Attractions sent");
  }
}

class ExploreItem extends StatelessWidget {
  final String image;
  final String text;

  const ExploreItem({Key? key, required this.image, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("img/" + image),
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            child: AppText(
              text,
              size: 10,
              color: AppColors.textColor2,
            ),
          ),
        ],
      ),
    );
  }
}

class TabView extends StatelessWidget {
  final List<AttractionModel> attractions;

  const TabView(this.attractions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: attractions.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () => Get.to(() => AttractionPage(attractions[index])),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, right: 15),
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(attractions[index].images.first)),
                ),
              ),
              Positioned(
                right: 10,
                left: 10,
                bottom: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(attractions[index].name, maxLines: 2, color: AppColors.white, weight: FontWeight.bold),
                    SizedBox(height: 5.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.place_outlined, size: 18.0, color: AppColors.white),
                        SizedBox(width: 4.0),
                        Expanded(child: AppText(attractions[index].address, maxLines: 2, color: AppColors.white)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CirclePainter(color: color, radius: radius);
  }
}

class CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(configuration.size!.width / 2 - radius / 2, configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
