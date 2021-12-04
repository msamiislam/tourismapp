import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:tourismapp/misc/colors.dart';
import 'package:tourismapp/widgets/large_txt.dart';

class RegistrationPage extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();

  RegistrationPage({Key? key}) : super(key: key);

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
                    AppLargeText(text: "Register with your Email"),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "first_name",
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          hintText: "Enter your first name", labelText: "First Name", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.email(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "last_name",
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: "Enter your last name", labelText: "Last Name", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.email(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "email",
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(hintText: "Enter your Email", labelText: "Email", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.email(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "phone_number",
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: "Enter your phone number", labelText: "Phone Number", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.email(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "address_line",
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: "Enter your address", labelText: "Address", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.email(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "blood_group",
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: "Enter your blood group", labelText: "Blood Group", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.email(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderDateTimePicker(
                      name: "date_of_birth",
                      inputType: InputType.date,
                      decoration: const InputDecoration(
                          hintText: "Select your date of birth", labelText: "Date of Birth", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    FormBuilderRadioGroup(
                      name: "gender",
                      options: [
                        FormBuilderFieldOption(value: "male", child: Text("Male")),
                        FormBuilderFieldOption(value: "female", child: Text("Female")),
                        FormBuilderFieldOption(value: "none", child: Text("none")),
                      ],
                      decoration: const InputDecoration(
                          hintText: "Select your gender", labelText: "Gender", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    TextButton(
                      onPressed: () {
                        Get.to(() => RegistrationPage());
                      },
                      child: Text("Signup"),
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
}
