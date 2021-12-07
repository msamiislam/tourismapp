import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class TripItineraryPage extends StatefulWidget {
  final void Function(Map<String, dynamic> map) onSaved;
  final VoidCallback? onPrevious;
  final int totalPages;
  final int currentPage;
  final Map<String, dynamic> initialValues;

  const TripItineraryPage({
    Key? key,
    required this.currentPage,
    required this.onSaved,
    required this.totalPages,
    required this.initialValues,
    this.onPrevious,
  }) : super(key: key);

  @override
  State<TripItineraryPage> createState() => _TripItineraryPageState();
}

class _TripItineraryPageState extends State<TripItineraryPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  List<String> timings = [];
  List<String> descriptions = [];
  List<Widget> activities = [];

  @override
  void initState() {
    super.initState();
    int index = activities.length;
    int fields = widget.initialValues.length ~/ 2;
    for (int i = 0; i < fields; i++) {
      activities.add(
        ActivityFields(
          timeName: 'time$i',
          time: widget.initialValues["time$i"],
          descName: "desc$i",
          desc: widget.initialValues["desc$i"],
        ),
      );
    }
    if (activities.isEmpty) {
      activities.add(
        ActivityFields(timeName: 'time$index', descName: 'desc$index'),
      );
    }
  }

  void addActivity() {
    int index = activities.length;
    setState(() {
      activities.add(
        ActivityFields(timeName: 'time$index', descName: 'desc$index'),
      );
    });
  }

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
                    AppText('Day ${widget.currentPage + 1}', size: 16.0, weight: FontWeight.w600),
                    SizedBox(height: 15.0),
                    if (activities.isNotEmpty)
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: activities.length,
                        itemBuilder: (context, index) => activities[index],
                      ),
                    AddButton(
                      onTap: () => addActivity(),
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
            if (widget.currentPage != 0)
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _fbKey.currentState!.save();
                    widget.onPrevious?.call();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AppText('Previous'),
                  ),
                ),
              ),
            if (widget.currentPage != 0) SizedBox(width: 10.0),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (_fbKey.currentState!.saveAndValidate()) {
                    widget.onSaved.call(_fbKey.currentState!.value);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(widget.currentPage == widget.totalPages - 1
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AppText(widget.currentPage == widget.totalPages - 1 ? 'Save' : "Next"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityFields extends StatelessWidget {
  final String timeName;
  final DateTime? time;
  final String descName;
  final String? desc;

  const ActivityFields({Key? key, this.time, this.desc, required this.timeName, required this.descName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.0,
          child: FormBuilderDateTimePicker(
            name: timeName,
            initialValue: time,
            inputType: InputType.time,
            decoration: InputDecoration(
              hintText: '9:00 am',
              border: OutlineInputBorder(),
            ),
            format: DateFormat.jm(),
            alwaysUse24HourFormat: false,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
            ]),
          ),
        ),
        SizedBox(height: 10.0),
        FormBuilderTextField(
          name: descName,
          initialValue: desc,
          minLines: 1,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Description',
            border: OutlineInputBorder(),
          ),
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
