import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourismapp/cubit/app_cubit_state.dart';
import 'package:tourismapp/cubit/app_cubits.dart';
import 'package:tourismapp/misc/colors.dart';
import 'package:tourismapp/widgets/large_txt.dart';
import 'package:tourismapp/widgets/simple_txt.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var images = {
    "hotel.png":"Hotel",
    "restaurant.jpg":"Restaurant",
    "mall.png":"Mall",
    "cab.jpg":"Cab",
    "train.png":"Train",
    "plane.png":"Plane",
  };
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state){
          if (state is LoadedState){
            var info=state.places;
            return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //upper Menu baricon + image
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20),
            child: Row(
              children: [
                Icon(Icons.menu, size: 28, color: Colors.black,),
                Expanded(child: Container(),),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                ),
              ],),
          ),
          SizedBox(height: 25,), //create a gap
          
          //Discover Text heading
          Container(
            margin: const EdgeInsets.only(left: 20,),
            child: AppLargeText(text: "Discover"),
          ),
          SizedBox(height: 20,), //create a gap

          //TabBar (which show the different thins within tabview and its carry less space)
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
                indicator: CircleTabIndicator(color: AppColors.mainColor, radius: 4),
                tabs: [
                  Tab(text: "Places",),
                  Tab(text: "Inspiration",),
                  Tab(text: "Emotions",)
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20),
            height: 300,
            width: 200,
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        BlocProvider.of<AppCubits>(context).detailpage(info[index]);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, right: 15),
                        width: 200,
                        height: 300,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "img/mountain.png"
                            )
                          )
                        )
                      ),
                    );
                  }
                ),
                Text("Hi"),
                Text("yes"),
              ],),
          ),
          SizedBox(height: 20,),
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppLargeText(
                  text: "Explore More", 
                  size: 20,),
                AppText(
                  text: "See all", 
                  color: AppColors.textColor1,),
                                
              ],
            ),
          ),

          SizedBox(height: 10,),
          Container(
            height: 100,
            width: double.maxFinite,
            margin: const EdgeInsets.only(left: 20),
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index){
              return Container(
                margin: const EdgeInsets.only(right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 80,
                        height: 80,
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "img/"+images.keys.elementAt(index)
                            )
                          )
                        )
                      ),
                      SizedBox(height: 10,),
                      
                    Container(
                      child: AppText(
                        text: images.values.elementAt(index),
                        size: 10,
                        color: AppColors.textColor2,),
                    )
                  ],
                ),
              );
            }),
          ),
        ],
      );
          }else{
            return Container();
          }
          
        },
      )
    );
  }
}

class CircleTabIndicator extends Decoration{
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return CirclePainter(color:color, radius:radius);
  }
  
}

class CirclePainter extends BoxPainter{
   final Color color;
  double radius;
  CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint= Paint();
    _paint.color=color;
    _paint.isAntiAlias=true;
    final Offset circleoffset= Offset(configuration.size!.width/2 - radius/2, configuration.size!.height-radius);
    canvas.drawCircle(offset+circleoffset, radius, _paint);
  }
  
}