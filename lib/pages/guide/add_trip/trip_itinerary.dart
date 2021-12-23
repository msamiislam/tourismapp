import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tourismapp/controllers/login_controller.dart';
import 'package:tourismapp/models/activity_model.dart';
import 'package:tourismapp/models/trip_model.dart';
import 'package:tourismapp/services/database.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class TripItineraryPage extends StatelessWidget {
  final int days;
  final Map<String, dynamic> tripInfo;

  TripItineraryPage({Key? key, required this.days, required this.tripInfo}) : super(key: key);

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  List<Map> tripItinerary = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Center(child: AppText('Step 2 of 2', size: 16.0, weight: FontWeight.w600)),
          SizedBox(width: 10.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilder(
                key: _fbKey,
                child: ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: days,
                  itemBuilder: (context, index) => DayActivities(
                    day: index + 1,
                    onActivityChanged: (int activities) {
                      tripItinerary.add({'day': index + 1, 'activities': activities});
                    },
                  ),
                  separatorBuilder: (BuildContext context, int index) => SizedBox(height: 15.0),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: ElevatedButton(
          onPressed: () => addTrip(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Add Trip'),
          ),
        ),
      ),
    );
  }

  void addTrip() {
    LoginController loginController = Get.find<LoginController>();
    if (_fbKey.currentState!.saveAndValidate()) {
      List<List<ActivityModel>> itinerary = [];
      List<ActivityModel> activities;
      for (var map in tripItinerary) {
        activities = [];
        int theDay = map['day'];
        for (int i = 0; i < map['activities']; i++) {
          int theActivity = i + 1;
          activities.add(
            ActivityModel()
              ..updateTime(_fbKey.currentState!.value['time$theActivity-$theDay'])
              ..updateDescription(_fbKey.currentState!.value['desc$theActivity-$theDay']),
          );
          // print(
          //     'Day $theDay - ${_fbKey.currentState!.value['time$theActivity-$theDay']} - ${_fbKey.currentState!.value['desc$theActivity-$theDay']}');
        }
        itinerary.add(activities);
      }
      Map<int, List<ActivityModel>> its = {};
      for (int i = 0; i < itinerary.length; i++) {
        its[i] = itinerary[i];
      }
      TripModel model = TripModel(
        id: 'id${DateTime.now().microsecondsSinceEpoch}',
        guideId: loginController.user!.id,
        guideName: loginController.user!.name,
        guideNumber: loginController.user!.phone,
        title: tripInfo['title'],
        location: tripInfo['loc'],
        description: tripInfo['desc'],
        images: [],
        estimatedCost: int.parse(tripInfo['price']),
        itinerary: {},
        touristIds: [],
      );
      Database.addTrips(model);
    }
  }
}

class DayActivities extends StatefulWidget {
  final int day;
  final void Function(int activities) onActivityChanged;

  const DayActivities({Key? key, required this.day, required this.onActivityChanged}) : super(key: key);

  @override
  State<DayActivities> createState() => _DayActivitiesState();
}

class _DayActivitiesState extends State<DayActivities> {
  int timing = 1;
  int description = 1;
  List<Widget> activities = [];
  bool showActivities = false;

  @override
  void initState() {
    super.initState();
    if (widget.day == 1) {
      showActivities = true;
    }
    activities.add(
      Activity(
        timeName: 'time${timing++}-${widget.day}',
        descName: 'desc${description++}-${widget.day}',
      ),
    );
    widget.onActivityChanged.call(activities.length);
  }

  addActivity() {
    setState(() {
      activities.add(
        Activity(
          timeName: 'time${timing++}-${widget.day}',
          descName: 'desc${description++}-${widget.day}',
        ),
      );
      widget.onActivityChanged.call(activities.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: SizedBox(
            height: 48.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText('Day ${widget.day}', size: 16.0, weight: FontWeight.w600),
                Spacer(),
                !showActivities ? Icon(Icons.keyboard_arrow_down) : Icon(Icons.keyboard_arrow_up),
              ],
            ),
          ),
          onTap: () {
            if (showActivities) {
              setState(() {
                showActivities = false;
              });
            } else {
              setState(() {
                showActivities = true;
              });
            }
          },
        ),
        Visibility(
          maintainState: true,
          visible: showActivities,
          child: Column(
            children: [
              ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: activities.length,
                itemBuilder: (context, index) => activities[index],
                separatorBuilder: (BuildContext context, int index) => SizedBox(height: 12.5),
              ),
              SizedBox(height: 10.0),
              AddButton(
                onTap: () => addActivity(),
                title: 'Add Activity',
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Activity extends StatelessWidget {
  final String timeName;
  final String descName;

  const Activity({Key? key, required this.timeName, required this.descName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.0,
          child: FormBuilderDateTimePicker(
            name: timeName,
            inputType: InputType.time,
            decoration: InputDecoration(
              hintText: '9:00 am',
              border: OutlineInputBorder(),
            ),
            format: DateFormat.jm(),
            alwaysUse24HourFormat: false,
            validator: FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
          ),
        ),
        SizedBox(height: 10.0),
        FormBuilderTextField(
          name: descName,
          minLines: 1,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Description',
            border: OutlineInputBorder(),
          ),
          validator: FormBuilderValidators.compose(
            [FormBuilderValidators.required(context)],
          ),
        ),
      ],
    );
  }
}

class AddButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AddButton({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(top: 5.0),
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
                SizedBox(width: 5.0),
                AppText(title, size: 16.0, color: Theme.of(context).colorScheme.primary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
