import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ndialog/ndialog.dart';
import '../widgets/simple_txt.dart';

abstract class Loader {
  static CustomProgressDialog? _dialog;

  static void show(BuildContext context, {String? text}) {
    _dialog = CustomProgressDialog(
      context,
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
                if (text != null) SizedBox(width: 10.0),
                if (text != null) AppText(text: text)
              ],
            ),
          ),
        ),
      ),
    );
    _dialog!.show();
  }

  static void hide() {
    if (_dialog != null) {
      _dialog!.dismiss();
    }
    _dialog = null;
  }
}
