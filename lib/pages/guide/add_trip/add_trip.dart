import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:tourismapp/pages/guide/add_trip/trip_itinerary.dart';

import '../../../utils/colors.dart';
import '../../../widgets/profile_image.dart';
import '../../../widgets/simple_txt.dart';
import 'add_trip_controller.dart';

class AddTripPage extends StatefulWidget {
  const AddTripPage({Key? key}) : super(key: key);

  @override
  State<AddTripPage> createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final AddTripController _tripController = Get.put(AddTripController());

  List<String> images = [];

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
                onPickedImages: (images) => this.images = [...images.map((e) => e.path)],
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
                    Row(
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
                                InkWell(onTap: _tripController.decrementDaysCount, child: Icon(FontAwesomeIcons.minusCircle)),
                                GetBuilder<AddTripController>(builder: (context) {
                                  return Text("${_tripController.daysCount}");
                                }),
                                InkWell(onTap: _tripController.incrementDaysCount, child: Icon(FontAwesomeIcons.plusCircle)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_fbKey.currentState!.saveAndValidate()) {
                            Map<String, dynamic> data = {..._fbKey.currentState!.value};
                            data['images'] = images;
                            Get.to(() => TripItineraryPage(
                                  days: _tripController.daysCount,
                                  tripInfo: data,
                                ));
                          }
                        },
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
