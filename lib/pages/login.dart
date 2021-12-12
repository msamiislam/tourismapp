import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../models/user_model.dart';
import '../pages/dashboard.dart';
import '../pages/registration_personal.dart';
import '../services/auth.dart';
import '../services/database.dart';
import '../utils/colors.dart';
import '../utils/progress_dialog.dart';
import '../widgets/large_txt.dart';
import '../widgets/password_field.dart';
import '../widgets/simple_txt.dart';
import 'guide/dashboard.dart';

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
                    AppLargeText( "Sign In with your Email"),
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
                    ElevatedButton(
                        onPressed: () => _login(context),
                        child: AppText( "Login", color: Colors.white, weight: FontWeight.bold),
                        ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText( "Don't have an account?"),
                        InkWell(
                            onTap: () => Get.to(() => RegistrationPersonalPage()),
                            child: AppText( " Sign up", color: AppColors.primary, weight: FontWeight.normal)),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                        onPressed: () => _loginWithGoogle(),
                        child: Text("Login with Google"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF4285F4)),
                        ),
                    ),
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
        UserCredential credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _fbKey.currentState!.value["email"], password: _fbKey.currentState!.value["password"]);
        UserModel user = await Database.getUser(credentials.user!.uid);
        final LoginController login = Get.find();
        login.updateUser(user);
        Loader.hide();
        if (user.isGuide) {
          Get.off(() => GuideDashboardPage());
        } else {
          Get.off(() => DashboardPage());
        }
        Fluttertoast.showToast(msg: "Logged in successfully.");
      } on FirebaseAuthException catch (exception) {
        Loader.hide();
        Get.dialog(AlertDialog(
          title: AppText("Login"),
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

  void _loginWithGoogle() async {
    try{
      UserCredential user = await
      AuthService.signInWithGoogle();
      log('Logged in: ${user.user}');

    }on FirebaseAuthException catch(e){
      log('Auth Exception - $e');
      //show a dialog or toast

    }catch(e){
      log('Exception - $e');

    }
  }
}
