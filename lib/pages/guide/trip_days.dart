import 'package:flutter/material.dart';
import 'package:tourismapp/pages/guide/trip_itinerary.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class TripDaysPage extends StatefulWidget {
  final int totalPages;

  const TripDaysPage(this.totalPages, {Key? key}) : super(key: key);

  @override
  State<TripDaysPage> createState() => _TripDaysPageState();
}

class _TripDaysPageState extends State<TripDaysPage> {
  final Map<String, dynamic> _map = {};
  int currentPage = 1;

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(child: AppText('Step 2 of 2', size: 16.0, weight: FontWeight.w600)),
          SizedBox(width: 10.0),
        ],
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.totalPages,
        onPageChanged: (val) => print(_map),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => TripItineraryPage(
            initialValues: _map["day$index"] ?? {},
            totalPages: widget.totalPages,
            currentPage: index,
            onPrevious: () {
              _controller.previousPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
            },
            onSaved: (map) {
              _map[index.toString()] = map;
              _controller.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
            }),
      ),
    );
  }
}
