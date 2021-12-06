import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../models/tourist_model.dart';
import '../pages/login.dart';
import '../utils/database.dart';
import '../utils/progress_dialog.dart';
import '../widgets/large_txt.dart';
import '../widgets/password_field.dart';
import '../widgets/simple_txt.dart';

class RegistrationAccount extends StatelessWidget {
  final Map<String, dynamic> personalDetails;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();

  RegistrationAccount(this.personalDetails, {Key? key}) : super(key: key);

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
      Map<String, dynamic> data = {}
        ..addAll(_fbKey.currentState!.value)
        ..addAll(personalDetails);
      log(_fbKey.currentState!.value.toString());
      Loader.show(context, text: "Registering...");
      try {
        UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _fbKey.currentState!.value["email"], password: _fbKey.currentState!.value["password"]);
        String? imageUrl;
        if (data["image"] != null && data["image"] is String) {
          imageUrl = await uploadImage(image: File(data["image"]), id: credential.user!.uid);
        }
        data["id"] = credential.user!.uid;
        data["image_url"] = imageUrl;
        Database.createTourist(TouristModel.fromJson(data));
        Loader.hide();
        FirebaseAuth.instance.signOut();
        Get.offAll(() => LoginPage());
        Fluttertoast.showToast(msg: "Registered successfully.");
      } on FirebaseAuthException catch (exception) {
        Loader.hide();
        Get.dialog(AlertDialog(
          title: AppText("Register"),
          content: AppText("${exception.message}", size: 14.0),
          actions: [
            TextButton(
              child: Text("Ok"),
              onPressed: () => Get.back(),
            )
          ],
        ));
      }
    }
  }

  Future<String> uploadImage({
    required File image,
    required String id,
  }) async {
    final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(id);
    UploadTask uploadTask = firebaseStorageRef.putFile(image);
    TaskSnapshot storageSnapshot = await uploadTask;
    return await storageSnapshot.ref.getDownloadURL();
  }
}
