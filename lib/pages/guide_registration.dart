import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:tourismapp/pages/registration_account.dart';

import '../widgets/large_txt.dart';
import '../widgets/simple_txt.dart';

class GuideRegistrationPage extends StatelessWidget {
  final Map<String, dynamic> personalDetails;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();

  GuideRegistrationPage(this.personalDetails, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FormBuilder(
                key: _fbKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 50.0),
                    AppLargeText("Enter your Professional Information"),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "city",
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: "Enter your city", labelText: "City", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "state",
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: "Enter your state", labelText: "State", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "company_name",
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: "Enter your company name", labelText: "Company", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    TextButton(
                        onPressed: () => _next(context),
                        child: AppText("Next", color: Colors.white, weight: FontWeight.bold),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        )),
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

  void _next(BuildContext context) async {
    if (_fbKey.currentState!.saveAndValidate()) {
      Map<String, dynamic> data = {}
        ..addAll(_fbKey.currentState!.value)
        ..addAll(personalDetails);
      log(_fbKey.currentState!.value.toString());
      Get.to(() => RegistrationAccountPage(data));
    }
  }
}
