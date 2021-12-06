import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourismapp/model/enums.dart';
import 'package:tourismapp/pages/registration_account.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/widgets/large_txt.dart';
import 'package:tourismapp/widgets/profile_image.dart';

class RegistrationPersonalPage extends StatefulWidget {
  const RegistrationPersonalPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPersonalPage> createState() => _RegistrationPersonalPageState();
}

class _RegistrationPersonalPageState extends State<RegistrationPersonalPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();

  XFile? profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FormBuilder(
                key: _fbKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 50.0),
                    AppLargeText(text: "Create Your Account"),
                    const SizedBox(height: 30.0),
                    Container(
                      width: Get.width / 2,
                      height: Get.width / 2,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ProfileImage(
                        radius: Get.width / 4,
                        onPicked: (imageFile) => profileImage = imageFile,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "first_name",
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          hintText: "Enter your first name", labelText: "First Name", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "last_name",
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          hintText: "Enter your last name", labelText: "Last Name", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "phone",
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                          hintText: "Enter your phone number", labelText: "Phone Number", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "address",
                      keyboardType: TextInputType.streetAddress,
                      decoration: const InputDecoration(
                          hintText: "Enter your address", labelText: "Address", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderRadioGroup(
                      name: "blood_group",
                      options: BloodGroup.values.map((e) => FormBuilderFieldOption(value: e)).toList(),
                      decoration: const InputDecoration(
                          hintText: "Enter your blood group", labelText: "Blood Group", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderDateTimePicker(
                      name: "dob",
                      inputType: InputType.date,
                      valueTransformer: (value) => value.toString(),
                      decoration: const InputDecoration(
                          hintText: "Select your date of birth",
                          labelText: "Date of Birth",
                          border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderRadioGroup(
                      name: "gender",
                      options: Gender.values
                          .map(
                            (e) => FormBuilderFieldOption(value: e),
                          )
                          .toList(),
                      decoration: const InputDecoration(
                          hintText: "Select your gender", labelText: "Gender", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    TextButton(
                      onPressed: _next,
                      child: Text("Next"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.buttonBackground),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _next() {
    if (_fbKey.currentState!.saveAndValidate()) {
      Map<String, dynamic> data = {}..addAll(_fbKey.currentState!.value);
      print(data.toString());
      data["image"] = profileImage?.path;
      log(data.toString());

      Get.to(() => RegistrationAccount(data));
    }
  }
}
