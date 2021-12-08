import 'package:cached_network_image/cached_network_image.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../../pages/detail.dart';
import '../../pages/profile.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/image_place_holder.dart';
import '../../widgets/large_txt.dart';
import '../../widgets/simple_txt.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final LoginController _login = LoginController();

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
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  final List<String> _tabs = ["Places", "Hotels", "Restaurants", "Malls"];
  final List<Widget> _tabViews = [
    TabView([1, 2, 3]),
    TabView([1, 2, 3]),
    TabView([1]),
    TabView([1, 3]),
  ];

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
                  AppLargeText("Discover"),
                  InkWell(
                    onTap: () {
                      Get.to(() => ProfilePage());
                    },
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
                  tabs: _tabs.map((e) => Tab(text: e)).toList(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 2.5, left: 20),
              height: 300,
              child: TabBarView(controller: _tabController, children: _tabViews),
            ),
            SizedBox(height: 20),
            ExploreSection(title: "Travels", nameImages: travelImages),
            SizedBox(height: 20),
            ExploreSection(title: "Guiders", nameImages: guiderImages),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ExploreSection extends StatelessWidget {
  const ExploreSection({
    Key? key,
    required this.nameImages,
    required this.title,
  }) : super(key: key);

  final Map<String, Map<String, String>> nameImages;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppLargeText("Explore $title", size: 20),
              AppText("See all", color: AppColors.textColor1),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 110,
          width: double.maxFinite,
          margin: const EdgeInsets.only(left: 20),
          child: ListView.builder(
            itemCount: nameImages.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {
                  if (title == "Travels") {
                    print("wow");
                    LaunchApp.openApp(
                      androidPackageName: nameImages.values.elementAt(index)["link"]!,
                      openStore: true,
                    );
                  }
                },
                child: Container(
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
                            image: AssetImage("img/" + nameImages.values.elementAt(index)["image"]!),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: AppText(
                          nameImages.keys.elementAt(index),
                          size: 10,
                          color: AppColors.textColor2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class TabView extends StatelessWidget {
  final List data;

  const TabView(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () => Get.to(() => DetailPage()),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, right: 15),
                width: 200,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  image: DecorationImage(fit: BoxFit.cover, image: NetworkImage("https://picsum.photos/200")),
                ),
              ),
              Positioned(
                right: 10,
                left: 10,
                bottom: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText('Title', maxLines: 2, color: AppColors.white, weight: FontWeight.bold),
                    SizedBox(height: 5.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.place_outlined, size: 18.0, color: AppColors.white),
                        SizedBox(width: 4.0),
                        Expanded(
                            child: AppText('Lorem ipsum is a dummy text used for industrial purposes.',
                                maxLines: 2, color: AppColors.white)),
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
