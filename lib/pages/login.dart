import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:tourismapp/pages/dashboard.dart';
import 'package:tourismapp/pages/registration_personal.dart';
import 'package:tourismapp/utils/progress_dialog.dart';
import 'package:tourismapp/services/auth.dart';
import 'package:tourismapp/utils/colors.dart';
import 'package:tourismapp/widgets/large_txt.dart';
import 'package:tourismapp/widgets/password_field.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey();

  LoginPage({Key? key}) : super(key: key);

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
                    AppLargeText(text: "Sign In with your Email"),
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
                    const SizedBox(height: 20.0),
                    TextButton(
                        onPressed: () => _login(context),
                        child: AppText(text: "Login", color: Colors.white, weight: FontWeight.bold),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        )),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(text: "Don't have an account?"),
                        InkWell(
                            onTap: () => Get.to(() => RegistrationPersonalPage()),
                            child: AppText(text: " Sign up", color: Colors.blue, weight: FontWeight.normal)),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    TextButton(
                        onPressed: () => _loginWithGoogle(),
                        child: Text("Login with Google"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(AppColors.buttonBackground),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    if (_fbKey.currentState!.saveAndValidate()) {
      log(_fbKey.currentState!.value.toString());
      Loader.show(context, text: "Logging In...");
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _fbKey.currentState!.value["email"], password: _fbKey.currentState!.value["password"]);
        Loader.hide();
        Get.to(() => DashboardPage());
        Fluttertoast.showToast(msg: "Logged in successfully.");
      } on FirebaseAuthException catch (exception) {
        Loader.hide();
        Get.dialog(AlertDialog(
          title: AppText(text: "Login"),
          content: AppText(text: "${exception.message}", size: 14.0),
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

  void _loginWithGoogle() async {
    try{
      UserCredential user = await
      AuthService.signInWithGoogle();
      print('--------- ${user.user}');

    }on FirebaseAuthException catch(e){
      print('--------- Auth Exception - $e');
      //show a dialog or toast

    }catch(e){
      print('--------- Exception - $e');

    }
  }
}
