import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tourismapp/models/guide_model.dart';
import 'package:tourismapp/models/user_model.dart';
import 'package:tourismapp/services/database.dart';
import 'package:tourismapp/services/storage.dart';
import 'package:tourismapp/utils/constants.dart';
import 'package:tourismapp/utils/progress_dialog.dart';

import '../controllers/login_controller.dart';
import '../models/enums.dart';
import '../utils/colors.dart';
import '../widgets/profile_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final LoginController _login = Get.find();
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
                    Container(
                      width: Get.width / 2,
                      height: Get.width / 2,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ProfileImage(
                        imageUrl: _login.user!.imageUrl,
                        radius: Get.width / 4,
                        onPicked: (imageFile) => profileImage = imageFile,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "email",
                      initialValue: _login.user!.email,
                      enabled: false,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          hintText: "Enter your first name", labelText: "Email", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "first_name",
                      initialValue: _login.user!.firstName,
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
                      initialValue: _login.user!.lastName,
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
                      initialValue: _login.user!.phone,
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
                      initialValue: _login.user!.address,
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
                      initialValue: _login.user?.bloodGroup,
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
                      initialValue: _login.user?.dob,
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
                      initialValue: _login.user!.gender,
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
                    if (!_login.isTourist!) ...[
                      FormBuilderDropdown<String>(
                        name: "city",
                        initialValue: (_login.user as GuideModel).city,
                        items:
                        Constants.cityContacts.keys.map((e) => DropdownMenuItem(child: Text(e), value: e),).toList(),
                        decoration: const InputDecoration(
                          hintText: "Select your city",
                          labelText: "City",
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      const SizedBox(height: 30.0),
                      FormBuilderDropdown<String>(
                        name: "state",
                        initialValue: (_login.user as GuideModel).state,
                        items:
                        Constants.states.map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                        decoration: const InputDecoration(
                            hintText: "Enter your state", labelText: "State", border: OutlineInputBorder()),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),                      const SizedBox(height: 30.0),
                      FormBuilderTextField(
                        name: "company_name",
                        initialValue: (_login.user! as GuideModel).companyName,
                        keyboardType: TextInputType.streetAddress,
                        decoration: const InputDecoration(
                            hintText: "Enter your company name", labelText: "Company", border: OutlineInputBorder()),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context),
                        ]),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                    TextButton(
                      onPressed: _update,
                      child: Text("Update"),
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

  void _update() async {
    if (_fbKey.currentState!.saveAndValidate()) {
      Map<String, dynamic> data = {}..addAll(_fbKey.currentState!.value);
      data["id"] = _login.user!.id;
      data["user_type"] = _login.user!.userType;
      Loader.show(context, text: "Updating...");
      String imageUrl = _login.user!.imageUrl;
      if (profileImage != null) {
        imageUrl = await Storage.uploadImage(image: File(profileImage!.path), id: _login.user!.id);
      }
      data["image_url"] = imageUrl;
      log(data.toString());
      UserModel user = UserModel.fromJson(data);
      await Database.updateUser(user);
      _login.updateUser(user);
      Loader.hide();
      Fluttertoast.showToast(msg: "Profile updated successfully.");
    }
  }
}
