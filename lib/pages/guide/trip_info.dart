import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../pages/guide/trip_days.dart';
import '../../utils/colors.dart';
import '../../widgets/profile_image.dart';
import '../../widgets/simple_txt.dart';

class TripInfoPage extends StatefulWidget {
  const TripInfoPage({Key? key}) : super(key: key);

  @override
  State<TripInfoPage> createState() => _TripInfoPageState();
}

class _TripInfoPageState extends State<TripInfoPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText("Add Trip"),
        actions: [
          Center(child: AppText('Step 1 of 2', size: 16.0, weight: FontWeight.w600)),
          SizedBox(width: 10.0),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MultiImage(
                onPickedImages: (images) {},
              ),
              SizedBox(height: 15.0),
              FormBuilder(
                key: _fbKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'title',
                      decoration: InputDecoration(
                        hintText: 'Trip Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    SizedBox(height: 15.0),
                    FormBuilderTextField(
                      name: 'loc',
                      decoration: InputDecoration(
                        hintText: 'Location',
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    SizedBox(height: 15.0),
                    FormBuilderTextField(
                      name: 'price',
                      decoration: InputDecoration(
                        hintText: 'Price (PKR) Estimate for 1 Person',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                    ),
                    SizedBox(height: 15.0),
                    FormBuilderTextField(
                      name: 'desc',
                      minLines: 3,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    SizedBox(height: 15.0),
                    Counter(
                      onChanged: (days) => count = days,
                    ),
                    SizedBox(height: 15.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => TripDaysPage(count)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: AppText('Next'),
                        ),
                      ),
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

class Counter extends StatefulWidget {
  final void Function(int counter) onChanged;

  const Counter({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 5.0),
        AppText("Trip Days: ", weight: FontWeight.w500),
        SizedBox(width: 20.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: AppColors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      if (count > 1) {
                        count--;
                        widget.onChanged.call(count);
                        setState(() {});
                      }
                    },
                    child: Icon(FontAwesomeIcons.minusCircle)),
                Text("$count"),
                InkWell(
                    onTap: () {
                      count++;
                      widget.onChanged.call(count);
                      setState(() {});
                    },
                    child: Icon(FontAwesomeIcons.plusCircle)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
