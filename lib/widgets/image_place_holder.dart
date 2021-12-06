import 'package:flutter/material.dart';

import 'simple_txt.dart';

class ImagePlaceHolder extends StatelessWidget {
  final String text;

  const ImagePlaceHolder(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: AppText(text));
  }
}
