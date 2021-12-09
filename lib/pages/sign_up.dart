import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:tourismapp/widgets/simple_txt.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: Get.width / 1.2,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            side: BorderSide(color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                      child: AppText('Explore as a Tourist'),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 1.2,
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.0),
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onPrimary),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            side: BorderSide(color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                      child: AppText('Provide services as a Guide', color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
