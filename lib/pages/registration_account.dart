import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:tourismapp/pages/login.dart';
import 'package:tourismapp/widgets/large_txt.dart';
import 'package:tourismapp/widgets/password_field.dart';

class RegistrationAccount extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();

  RegistrationAccount({Key? key}) : super(key: key);

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
                  children: <Widget>[
                    const SizedBox(height: 50.0),
                    AppLargeText(text: "Sign Up with your Email"),
                    const SizedBox(height: 30.0),
                    FormBuilderTextField(
                      name: "email",
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: "Enter your Email", labelText: "Email", border: OutlineInputBorder()),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.email(context),
                      ]),
                    ),
                    const SizedBox(height: 30.0),
                    PasswordField(),
                    const SizedBox(height: 30.0),
                    TextButton(
                      onPressed: _register,
                      child: Text("Sign Up"),
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

  void _register() {
    if (_fbKey.currentState!.saveAndValidate()) {
      print(_fbKey.currentState!.value);
      Get.off(() => LoginPage());
    }
  }
}
