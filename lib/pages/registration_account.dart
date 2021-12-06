import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ndialog/ndialog.dart';
import 'package:tourismapp/pages/login.dart';
import 'package:tourismapp/widgets/large_txt.dart';
import 'package:tourismapp/widgets/password_field.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 50.0),
                    AppLargeText("Sign Up with your Email"),
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
                        onPressed: () => _register(context),
                        child: AppText("Register", color: Colors.white, weight: FontWeight.bold),
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

  void _register(BuildContext context) async {
    if (_fbKey.currentState!.saveAndValidate()) {
      CustomProgressDialog dialog = CustomProgressDialog(context,
          dismissable: false,
          loadingWidget: SizedBox(
            width: Get.width * 0.7,
            height: 80.0,
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    LoadingAnimationWidget.fourRotatingDots(color: Colors.blue, size: 40.0),
                    SizedBox(width: 10.0),
                    AppText("Registering...")
                  ],
                ),
              ),
            ),
          ));
      log(_fbKey.currentState!.value.toString());
      dialog.show();
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _fbKey.currentState!.value["email"], password: _fbKey.currentState!.value["password"]);
        dialog.dismiss();
        Get.to(() => LoginPage());
        Fluttertoast.showToast(msg: "Registered successfully.");
      } on FirebaseAuthException catch (exception) {
        dialog.dismiss();
        Get.dialog(
          AlertDialog(
            title: AppText("Register"),
            content: AppText("${exception.message}", size: 14.0),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () => Get.back(),
              )
            ],
          ),
        );
      }
    }
  }
}
