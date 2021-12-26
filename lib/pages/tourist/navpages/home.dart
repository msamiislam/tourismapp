import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tourismapp/controllers/login_controller.dart';
import 'package:tourismapp/models/attraction_model.dart';
import 'package:tourismapp/models/enums.dart';
import 'package:tourismapp/models/guide_model.dart';
import 'package:tourismapp/models/hotel_model.dart';
import 'package:tourismapp/models/mall_model.dart';
import 'package:tourismapp/models/place_model.dart';
import 'package:tourismapp/models/restaurant_model.dart';
import 'package:tourismapp/models/user_model.dart';
import 'package:tourismapp/pages/tourist/all_guides.dart';
import 'package:tourismapp/pages/tourist/guide.dart';
import 'package:tourismapp/services/database.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/utils/constants.dart';
import 'package:tourismapp/widgets/image_place_holder.dart';
import 'package:tourismapp/widgets/large_txt.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

import '../../attraction.dart';
import '../../profile.dart';

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
    "Uber": {
      "image": "uber.png",
      "link": Constants.cabPackageName,
    },
    "Pakistan Railways": {
      "image": "railway.jpeg",
      "link": Constants.trainPackageName,
    },
    "PIA": {
      "image": "pia.png",
      "link": Constants.planePackageName,
    },
    "Daewoo": {
      "image": "daewoo.gif",
      "link": Constants.busPackageName,
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
                            progressIndicatorBuilder: (context, url, progress) => ImagePlaceHolder(_login.user!.initials),
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
                  labelColor: Theme.of(context).colorScheme.onBackground,
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
              margin: const EdgeInsets.only(left: 20, top: 10),
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
                        image: travelImages.values.elementAt(index)["image"]!, text: travelImages.keys.elementAt(index)),
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
                  InkWell(onTap: () => Get.to(() => AllGuidesPage()), child: AppText("See all", color: AppColors.textColor1)),
                ],
              ),
            ),
            Container(
              height: 110,
              width: double.maxFinite,
              margin: const EdgeInsets.only(left: 20, top: 10),
              child: FutureBuilder<List<UserModel>>(
                  future: Database.getUsers(UserType.guide, limit: 4),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    List<UserModel> users = snapshot.data!;
                    return ListView.builder(
                      itemCount: users.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () => Get.to(() => GuideProfilePage(users[index] as GuideModel)),
                          child: ExploreItem(
                            image: users[index].imageUrl,
                            text: users[index].name,
                            isGuide: true,
                          ),
                        );
                      },
                    );
                  }),
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
  final bool isGuide;

  const ExploreItem({Key? key, required this.image, required this.text, this.isGuide = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                image: isGuide
                    ? null
                    : DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("img/" + image),
                      ),
              ),
              child: isGuide
                  ? Material(
                      clipBehavior: Clip.antiAlias,
                      elevation: 4.0,
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(25.0),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        width: 70.0,
                        height: 70.0,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) => ImagePlaceHolder(
                            text.split(" ").first.substring(0, 1).toUpperCase() +
                                text.split(" ").last.substring(0, 1).toUpperCase()),
                        errorWidget: (context, url, error) => ImagePlaceHolder(
                            text.split(" ").first.substring(0, 1).toUpperCase() +
                                text.split(" ").last.substring(0, 1).toUpperCase()),
                      ),
                    )
                  : null),
          SizedBox(height: 5),
          SizedBox(
            width: 60.0,
            height: 35.0,
            child: AppText(
              text,
              textAlign: TextAlign.center,
              maxLines: 2,
              size: 12,
              color: Theme.of(context).colorScheme.onBackground,
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
    if (attractions.isEmpty) {
      return Center(child: AppText("Empty List"));
    }
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
