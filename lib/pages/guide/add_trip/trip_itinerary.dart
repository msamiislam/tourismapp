import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

import 'add_trip_controller.dart';

class TripItineraryPage extends StatelessWidget {
  final AddTripController _tripController = Get.find();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  TripItineraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                key: _fbKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'Day ${_tripController.currentPage + 1}',
                      size: 16.0,
                      weight: FontWeight.w600,
                    ),
                    SizedBox(height: 15.0),
                    GetBuilder<AddTripController>(
                      didUpdateWidget: (oldWidget, state) => state.controller!.currentDay == _tripController.currentDay,
                      builder: (context) => ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: _tripController.currentDay.activitiesCount,
                          itemBuilder: (context, index) {
                            return Stack(
                              alignment: Alignment.topRight,
                              children: [
                                ActivityFields(
                                  time: _tripController.currentDay.activities[index].time,
                                  desc: _tripController.currentDay.activities[index].description,
                                  onTimeChanged: _tripController.currentDay.activities[index].updateTime,
                                  onDescriptionChanged: _tripController.currentDay.activities[index].updateDescription,
                                ),
                                if (index != 0 && index == _tripController.currentDay.activitiesCount - 1)
                                  IconButton(
                                    onPressed: _tripController.removeActivityFromCurrentDay,
                                    icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.primary),
                                  ),
                              ],
                            );
                          },
                        )
                    ),
                    AddButton(
                      onTap: _tripController.addActivityToCurrentDay,
                      title: 'Add Activity',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            if (!_tripController.isFirstPage) ...[
              Expanded(
                child: ElevatedButton(
                  onPressed: _tripController.goToPreviousPage,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AppText('Previous'),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
            ],
            Expanded(
              child: ElevatedButton(
                onPressed: _tripController.goToNextPage,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(_tripController.isLastPage
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AppText(_tripController.isLastPage ? 'Save' : "Next"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityFields extends StatefulWidget {
  final DateTime? time;
  final String? desc;
  final void Function(DateTime? time) onTimeChanged;
  final void Function(String? time) onDescriptionChanged;

  const ActivityFields(
      {Key? key, this.time, this.desc, required this.onTimeChanged, required this.onDescriptionChanged})
      : super(key: key);

  @override
  State<ActivityFields> createState() => _ActivityFieldsState();
}

class _ActivityFieldsState extends State<ActivityFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.0,
          child: FormBuilderDateTimePicker(
            name: "time",
            initialValue: widget.time,
            inputType: InputType.time,
            decoration: InputDecoration(
              hintText: '9:00 am',
              border: OutlineInputBorder(),
            ),
            onChanged: (time) {
              print(time);
              widget.onTimeChanged(time);
              },
            format: DateFormat.jm(),
            alwaysUse24HourFormat: false,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
          ),
        ),
        SizedBox(height: 10.0),
        FormBuilderTextField(
          name: "description",
          initialValue: widget.desc,
          minLines: 1,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Description',
            border: OutlineInputBorder(),
          ),
          onChanged: widget.onDescriptionChanged,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(context),
          ]),
        ),
        SizedBox(height: 10.0),
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
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(top: 5.0),
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          width: 150.0,
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
    );
  }
}
