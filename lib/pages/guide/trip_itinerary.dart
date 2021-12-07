import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class TripItineraryPage extends StatefulWidget {
  TripItineraryPage({Key? key}) : super(key: key);

  @override
  State<TripItineraryPage> createState() => _TripItineraryPageState();
}

class _TripItineraryPageState extends State<TripItineraryPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  int day = 0;

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
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                key: _fbKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText('Day ${day + 1}', size: 16.0, weight: FontWeight.w600),
                    SizedBox(height: 15.0),
                    SizedBox(
                      width: 90.0,
                      child: FormBuilderDateTimePicker(
                        name: 'time',
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
                      name: 'desc',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
